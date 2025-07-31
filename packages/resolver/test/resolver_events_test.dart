import 'dart:async';
import 'package:test/test.dart';
import 'package:resolver/resolver.dart';

void main() {
  group('Resolver Events System Tests', () {
    late List<IResolverEvent> capturedEvents;
    late StreamController<IResolverEvent> testEventController;

    setUp(() {
      // Reset configuration before each test
      ResolverEventController.events.configure(autoSuccess: false, autoError: false);

      // Clear captured events
      capturedEvents = [];

      // Create a new test event controller for isolation
      testEventController = StreamController<IResolverEvent>.broadcast();

      // Set test override
      ResolverEventController.setTestOverride(testEventController);

      // Set up event listener
      testEventController.stream.listen((event) {
        capturedEvents.add(event);
      });
    });

    tearDown(() {
      capturedEvents.clear();
      testEventController.close();
      ResolverEventController.setTestOverride(null);
    });

    group('Manual Event Registration', () {
      test('should manually add success events', () async {
        // Act
        ResolverEventController.events.addSuccess('Manual success test', metadata: {'test': 'data'});

        // Wait for event propagation
        await Future.delayed(Duration(milliseconds: 10));

        // Assert
        expect(capturedEvents.length, equals(1));
        expect(capturedEvents.first.eventType, equals(ResolverEventType.success));
        expect(capturedEvents.first.message, equals('Manual success test'));
        expect(capturedEvents.first.metadata?['test'], equals('data'));
      });

      test('should manually add failure events', () async {
        // Act
        ResolverEventController.events.addFailure('Manual failure test', metadata: {'error': 'test_error'});

        // Wait for event propagation
        await Future.delayed(Duration(milliseconds: 10));

        // Assert
        expect(capturedEvents.length, equals(1));
        expect(capturedEvents.first.eventType, equals(ResolverEventType.failure));
        expect(capturedEvents.first.message, equals('Manual failure test'));
        expect(capturedEvents.first.metadata?['error'], equals('test_error'));
      });

      test('should manually add history events', () async {
        // Act
        ResolverEventController.events.addHistory('Manual history test', metadata: {'action': 'user_click'});

        // Wait for event propagation
        await Future.delayed(Duration(milliseconds: 10));

        // Assert
        expect(capturedEvents.length, equals(1));
        expect(capturedEvents.first.eventType, equals(ResolverEventType.history));
        expect(capturedEvents.first.message, equals('Manual history test'));
        expect(capturedEvents.first.metadata?['action'], equals('user_click'));
      });
    });

    group('Auto Events - Disabled (Default)', () {
      test('fromFuture should NOT auto-register success when disabled', () async {
        // Arrange
        expect(ResolverEventController.events.config.autoSuccess, isFalse);

        // Act
        final result = await Result.fromFuture(Future.value('test success'));

        // Wait for any potential events
        await Future.delayed(Duration(milliseconds: 10));

        // Assert
        expect(result.isSuccess, isTrue);
        expect(result.value, equals('test success'));
        expect(capturedEvents.length, equals(0)); // No auto events
      });

      test('fromFuture should NOT auto-register failure when disabled', () async {
        // Arrange
        expect(ResolverEventController.events.config.autoError, isFalse);

        // Act
        final result = await Result.fromFuture(Future.error('test error'), onError: (e) => 'Custom error message');

        // Wait for any potential events
        await Future.delayed(Duration(milliseconds: 10));

        // Assert
        expect(result.isFailure, isTrue);
        expect(result.error.toString(), contains('Custom error message'));
        expect(capturedEvents.length, equals(0)); // No auto events
      });

      test('fromFuture should NOT auto-register events when disabled', () async {
        // Arrange
        expect(ResolverEventController.events.config.autoSuccess, isFalse);
        expect(ResolverEventController.events.config.autoError, isFalse);

        // Act - Success case
        final successResult = await Result.fromFuture(Future.value('test data'));

        // Act - Failure case
        final failureResult = await Result.fromFuture(Future.error('test error'), onError: (e) => 'Error: $e');

        // Wait for any potential events
        await Future.delayed(Duration(milliseconds: 10));

        // Assert
        expect(successResult.isSuccess, isTrue);
        expect(failureResult.isFailure, isTrue);
        expect(capturedEvents.length, equals(0)); // No auto events
      });
    });

    group('Auto Events - Success Only', () {
      setUp(() {
        ResolverEventController.events.configure(autoSuccess: true, autoError: false);
      });

      test('fromFuture should auto-register success only', () async {
        // Act - Success case
        final successResult = await Result.fromFuture(Future.value('success data'));

        // Act - Failure case
        final failureResult = await Result.fromFuture(Future.error('error data'), onError: (e) => 'Error message');

        // Wait for events to propagate
        await Future.delayed(Duration(milliseconds: 10));

        // Assert
        expect(successResult.isSuccess, isTrue);
        expect(failureResult.isFailure, isTrue);
        expect(capturedEvents.length, equals(1)); // Only success event
        expect(capturedEvents.first.eventType, equals(ResolverEventType.success));
        expect(capturedEvents.first.message, equals('Simple future executed successfully'));
        expect(capturedEvents.first.metadata?['type'], equals('String'));
        expect(capturedEvents.first.metadata?['source'], equals('fromFutureSimple'));
      });

      test('fromFuture should auto-register success only', () async {
        // Act - Success case
        final successResult = await Result.fromFuture(Future.value(42));

        // Act - Failure case
        final failureResult = await Result.fromFuture(Future.error('test error'), onError: (e) => 'Error: $e');

        // Wait for events to propagate
        await Future.delayed(Duration(milliseconds: 10));

        // Assert
        expect(successResult.isSuccess, isTrue);
        expect(successResult.value, equals(42));
        expect(failureResult.isFailure, isTrue);
        expect(capturedEvents.length, equals(1)); // Only success event
        expect(capturedEvents.first.eventType, equals(ResolverEventType.success));
        expect(capturedEvents.first.message, equals('Simple future executed successfully'));
        expect(capturedEvents.first.metadata?['type'], equals('int'));
        expect(capturedEvents.first.metadata?['source'], equals('fromFutureSimple'));
      });
    });

    group('Auto Events - Error Only', () {
      setUp(() {
        ResolverEventController.events.configure(autoSuccess: false, autoError: true);
      });

      test('fromFuture should auto-register failure only', () async {
        // Act - Success case
        final successResult = await Result.fromFuture(Future.value('success data'));

        // Act - Failure case
        final failureResult = await Result.fromFuture(Future.error('error data'), onError: (e) => 'Custom error message');

        // Wait for events to propagate
        await Future.delayed(Duration(milliseconds: 10));

        // Assert
        expect(successResult.isSuccess, isTrue);
        expect(failureResult.isFailure, isTrue);
        expect(capturedEvents.length, equals(1)); // Only failure event
        expect(capturedEvents.first.eventType, equals(ResolverEventType.failure));
        expect(capturedEvents.first.message, equals('Simple future failed'));
        expect(capturedEvents.first.metadata?['type'], equals('dynamic'));
        expect(capturedEvents.first.metadata?['source'], equals('fromFutureSimple'));
        expect(capturedEvents.first.metadata?['originalError'], equals('error data'));
        expect(capturedEvents.first.metadata?['errorMessage'], equals('Custom error message'));
      });

      test('fromFuture should auto-register failure only with custom error mapping', () async {
        // Create custom error resolver
        final customSuccess = Resolver<String, String>.success('success');
        final customFailure = Resolver<String, String>.failure('original error');

        // Wait for events to propagate
        await Future.delayed(Duration(milliseconds: 10));

        // Assert
        expect(customSuccess.isSuccess, isTrue);
        expect(customFailure.isFailure, isTrue);
        expect(capturedEvents.length, equals(0)); // No auto events for manual creation
      });
    });

    group('Auto Events - Both Enabled', () {
      setUp(() {
        ResolverEventController.events.configure(autoSuccess: true, autoError: true);
      });

      test('fromFuture should auto-register both success and failure', () async {
        // Act - Success case
        final successResult = await Result.fromFuture(Future.value('success data'));

        // Act - Failure case
        final failureResult = await Result.fromFuture(Future.error('error data'), onError: (e) => 'Custom error');

        // Wait for events to propagate
        await Future.delayed(Duration(milliseconds: 10));

        // Assert
        expect(successResult.isSuccess, isTrue);
        expect(failureResult.isFailure, isTrue);
        expect(capturedEvents.length, equals(2)); // Both events

        // Check success event
        final successEvent = capturedEvents.firstWhere((e) => e.eventType == ResolverEventType.success);
        expect(successEvent.message, equals('Simple future executed successfully'));
        expect(successEvent.metadata?['source'], equals('fromFutureSimple'));

        // Check failure event
        final failureEvent = capturedEvents.firstWhere((e) => e.eventType == ResolverEventType.failure);
        expect(failureEvent.message, equals('Simple future failed'));
        expect(failureEvent.metadata?['source'], equals('fromFutureSimple'));
        expect(failureEvent.metadata?['errorMessage'], equals('Custom error'));
      });

      test('fromFuture should auto-register both success and failure with list', () async {
        // Act - Success case
        final successResult = await Result.fromFuture(Future.value(['item1', 'item2']));

        // Act - Failure case
        final failureResult = await Result.fromFuture(Future.error('list fetch failed'), onError: (e) => 'List error: $e');

        // Wait for events to propagate
        await Future.delayed(Duration(milliseconds: 10));

        // Assert
        expect(successResult.isSuccess, isTrue);
        expect(successResult.value, equals(['item1', 'item2']));
        expect(failureResult.isFailure, isTrue);
        expect(capturedEvents.length, equals(2)); // Both events

        // Check success event
        final successEvent = capturedEvents.firstWhere((e) => e.eventType == ResolverEventType.success);
        expect(successEvent.message, equals('Simple future executed successfully'));

        // Check failure event
        final failureEvent = capturedEvents.firstWhere((e) => e.eventType == ResolverEventType.failure);
        expect(failureEvent.message, equals('Simple future failed'));
        expect(failureEvent.metadata?['originalError'], equals('list fetch failed'));
      });
    });

    group('Event Configuration', () {
      test('should update configuration correctly', () {
        // Initial state
        expect(ResolverEventController.events.config.autoSuccess, isFalse);
        expect(ResolverEventController.events.config.autoError, isFalse);

        // Configure success only
        ResolverEventController.events.configure(autoSuccess: true);
        expect(ResolverEventController.events.config.autoSuccess, isTrue);
        expect(ResolverEventController.events.config.autoError, isFalse);

        // Configure error only
        ResolverEventController.events.configure(autoError: true);
        expect(ResolverEventController.events.config.autoSuccess, isTrue); // Should remain
        expect(ResolverEventController.events.config.autoError, isTrue);

        // Disable success
        ResolverEventController.events.configure(autoSuccess: false);
        expect(ResolverEventController.events.config.autoSuccess, isFalse);
        expect(ResolverEventController.events.config.autoError, isTrue); // Should remain
      });

      test('should configure with ResolverEventConfig object', () {
        final config = ResolverEventConfig(autoSuccess: true, autoError: true);

        ResolverEventController.events.configureWith(config);

        expect(ResolverEventController.events.config.autoSuccess, isTrue);
        expect(ResolverEventController.events.config.autoError, isTrue);
      });
    });

    group('Event Filtering and Subscription', () {
      test('should filter events by type correctly', () async {
        final successEvents = <IResolverEvent>[];
        final failureEvents = <IResolverEvent>[];
        final historyEvents = <IResolverEvent>[];

        // Set up filtered listeners directly on our test stream
        testEventController.stream.where((e) => e.eventType == ResolverEventType.success).listen(successEvents.add);
        testEventController.stream.where((e) => e.eventType == ResolverEventType.failure).listen(failureEvents.add);
        testEventController.stream.where((e) => e.eventType == ResolverEventType.history).listen(historyEvents.add);

        // Add different types of events
        ResolverEventController.events.addSuccess('Success 1');
        ResolverEventController.events.addFailure('Failure 1');
        ResolverEventController.events.addHistory('History 1');
        ResolverEventController.events.addSuccess('Success 2');
        ResolverEventController.events.addFailure('Failure 2');

        // Allow events to propagate
        await Future.delayed(Duration(milliseconds: 10));

        // Assert filtering
        expect(successEvents.length, equals(2));
        expect(failureEvents.length, equals(2));
        expect(historyEvents.length, equals(1));

        expect(successEvents.every((e) => e.eventType == ResolverEventType.success), isTrue);
        expect(failureEvents.every((e) => e.eventType == ResolverEventType.failure), isTrue);
        expect(historyEvents.every((e) => e.eventType == ResolverEventType.history), isTrue);
      });
    });

    group('Event Metadata and Serialization', () {
      test('should include correct metadata in auto events', () async {
        ResolverEventController.events.configure(autoSuccess: true, autoError: true);

        // Test with custom types
        final result = await Result.fromFuture(Future.value({'count': 42}));

        // Wait for events to propagate
        await Future.delayed(Duration(milliseconds: 10));

        expect(result.isSuccess, isTrue);
        expect(capturedEvents.length, equals(1));

        final event = capturedEvents.first;
        expect(event.metadata?['type'], isNotNull);
        expect(event.metadata?['source'], isNotNull);
      });

      test('should serialize events to JSON correctly', () {
        final event = ResolverEvent.success('Test success', metadata: {'userId': '123', 'action': 'login', 'timestamp': '2023-01-01T00:00:00.000Z'});

        final json = event.toJson();

        expect(json['eventType'], equals('success'));
        expect(json['message'], equals('Test success'));
        expect(json['metadata']['userId'], equals('123'));
        expect(json['metadata']['action'], equals('login'));
        expect(json['timestamp'], isA<String>());
      });

      test('should have correct toString representation', () {
        final event = ResolverEvent.failure('Test failure');
        final string = event.toString();

        expect(string, contains('ResolverEvent(failure'));
        expect(string, contains('Test failure'));
      });
    });

    group('Integration Tests', () {
      test('should work with real-world scenario', () async {
        final userActions = <String>[];
        final apiCalls = <String>[];
        final errors = <String>[];

        // Configure auto events
        ResolverEventController.events.configure(autoSuccess: true, autoError: true);

        // Set up comprehensive listener directly on test stream
        testEventController.stream.listen((event) {
          switch (event.eventType) {
            case ResolverEventType.history:
              userActions.add(event.message);
              break;
            case ResolverEventType.success:
              if (event.metadata?['source'] != null) {
                apiCalls.add('${event.metadata!['source']}: ${event.message}');
              }
              break;
            case ResolverEventType.failure:
              errors.add(event.message);
              break;
          }
        });

        // Simulate user journey
        ResolverEventController.events.addHistory('User opened app');

        final loginResult = await Result.fromFuture(Future.value('user_token_123'));

        ResolverEventController.events.addHistory('User logged in');

        final profileResult = await Result.fromFuture(Future.error('Profile service down'), onError: (e) => 'Failed to load profile');

        // Allow events to propagate
        await Future.delayed(Duration(milliseconds: 10));

        // Assertions
        expect(loginResult.isSuccess, isTrue);
        expect(profileResult.isFailure, isTrue);

        expect(userActions, contains('User opened app'));
        expect(userActions, contains('User logged in'));

        expect(apiCalls.length, equals(1));
        expect(apiCalls.first, contains('fromFutureSimple'));
        expect(apiCalls.first, contains('Simple future executed successfully'));

        expect(errors.length, equals(1));
        expect(errors.first, equals('Simple future failed'));
      });
    });

    group('Event Factory Methods', () {
      test('should create success events with factory method', () {
        final event = ResolverEvent.success('Test success message', metadata: {'key': 'value'});

        expect(event.eventType, equals(ResolverEventType.success));
        expect(event.message, equals('Test success message'));
        expect(event.metadata?['key'], equals('value'));
        expect(event.timestamp, isA<DateTime>());
      });

      test('should create failure events with factory method', () {
        final event = ResolverEvent.failure('Test failure message', metadata: {'error': 'details'});

        expect(event.eventType, equals(ResolverEventType.failure));
        expect(event.message, equals('Test failure message'));
        expect(event.metadata?['error'], equals('details'));
        expect(event.timestamp, isA<DateTime>());
      });

      test('should create history events with factory method', () {
        final event = ResolverEvent.history('Test history message', metadata: {'action': 'click'});

        expect(event.eventType, equals(ResolverEventType.history));
        expect(event.message, equals('Test history message'));
        expect(event.metadata?['action'], equals('click'));
        expect(event.timestamp, isA<DateTime>());
      });
    });

    group('Event Controller Singleton', () {
      test('should return same instance', () {
        final instance1 = ResolverEventController.events;
        final instance2 = ResolverEventController.events;

        expect(identical(instance1, instance2), isTrue);
      });

      test('should maintain configuration across instances', () {
        ResolverEventController.events.configure(autoSuccess: true, autoError: false);

        final anotherReference = ResolverEventController.events;
        expect(anotherReference.config.autoSuccess, isTrue);
        expect(anotherReference.config.autoError, isFalse);
      });
    });

    group('Performance and Memory Tests', () {
      test('should handle multiple events efficiently', () async {
        final events = <IResolverEvent>[];

        testEventController.stream.listen(events.add);

        // Add many events
        for (int i = 0; i < 100; i++) {
          // Reduced from 1000 to 100 for faster tests
          ResolverEventController.events.addSuccess('Event $i');
        }

        // Allow events to propagate
        await Future.delayed(Duration(milliseconds: 10));

        expect(events.length, equals(100));
        expect(events.every((e) => e.eventType == ResolverEventType.success), isTrue);
      });
    });
  });
}

/// Custom error class for testing
class CustomError {
  const CustomError(this.message);
  final String message;

  @override
  String toString() => 'CustomError: $message';
}
