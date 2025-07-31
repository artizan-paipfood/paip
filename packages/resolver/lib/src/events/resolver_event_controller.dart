import 'dart:async';

import 'resolver_event.dart';

/// **Event subscriber for listening to specific resolver events**
///
/// Provides filtered streams for different event types (success, failure, history).
/// This class is used internally by the event system to provide type-specific callbacks.
///
/// ## Example
/// ```dart
/// ResolverEventController.events.listen((subscriber) {
///   subscriber.onSuccess((event) => print('Success: ${event.message}'));
///   subscriber.onFailure((event) => print('Error: ${event.message}'));
/// });
/// ```
class EventSubscriber {
  final Stream<IResolverEvent> _eventStream;

  EventSubscriber(this._eventStream);

  /// **Listens to success events**
  ///
  /// Filters the event stream to only include success events and calls the provided
  /// [callback] for each success event.
  ///
  /// ## Parameters
  /// - [callback]: Function to execute for each success event
  ///
  /// ## Example
  /// ```dart
  /// subscriber.onSuccess((event) {
  ///   print('Operation succeeded: ${event.message}');
  ///   print('Metadata: ${event.metadata}');
  /// });
  /// ```
  void onSuccess(void Function(IResolverEvent event) callback) {
    _eventStream.where((event) => event.eventType == ResolverEventType.success).listen(callback);
  }

  /// **Listens to failure events**
  ///
  /// Filters the event stream to only include failure events and calls the provided
  /// [callback] for each failure event.
  ///
  /// ## Parameters
  /// - [callback]: Function to execute for each failure event
  ///
  /// ## Example
  /// ```dart
  /// subscriber.onFailure((event) {
  ///   print('Operation failed: ${event.message}');
  ///   logError(event.metadata?['originalError']);
  /// });
  /// ```
  void onFailure(void Function(IResolverEvent event) callback) {
    _eventStream.where((event) => event.eventType == ResolverEventType.failure).listen(callback);
  }

  /// **Listens to history events**
  ///
  /// Filters the event stream to only include history events and calls the provided
  /// [callback] for each history event.
  ///
  /// ## Parameters
  /// - [callback]: Function to execute for each history event
  ///
  /// ## Example
  /// ```dart
  /// subscriber.onHistory((event) {
  ///   print('User action: ${event.message}');
  ///   analytics.track(event.metadata);
  /// });
  /// ```
  void onHistory(void Function(IResolverEvent event) callback) {
    _eventStream.where((event) => event.eventType == ResolverEventType.history).listen(callback);
  }
}

/// **Configuration for automatic event registration**
///
/// Controls which events are automatically registered when using Resolver methods
/// like [fromFuture] and [fromFutureSimple].
///
/// ## Properties
/// - [autoSuccess]: Whether to automatically register success events
/// - [autoError]: Whether to automatically register failure events
///
/// ## Example
/// ```dart
/// final config = ResolverEventConfig(
///   autoSuccess: true,
///   autoError: true,
/// );
/// ResolverEventController.events.configureWith(config);
/// ```
class ResolverEventConfig {
  const ResolverEventConfig({this.autoSuccess = false, this.autoError = false});

  /// **Whether to automatically register success events**
  final bool autoSuccess;

  /// **Whether to automatically register failure events**
  final bool autoError;
}

/// **Main controller for resolver events**
///
/// Singleton class that manages the event stream and provides methods for
/// registering and listening to resolver events.
///
/// ## Features
/// - Automatic event registration for Resolver operations
/// - Manual event registration
/// - Type-safe event filtering
/// - Configurable auto-registration
///
/// ## Example
/// ```dart
/// // Configure automatic events
/// ResolverEventController.events.configure(
///   autoSuccess: true,
///   autoError: true,
/// );
///
/// // Listen to events
/// ResolverEventController.events.listen((subscriber) {
///   subscriber.onSuccess((event) => print('Success: ${event.message}'));
///   subscriber.onFailure((event) => print('Error: ${event.message}'));
/// });
///
/// // Manual event registration
/// ResolverEventController.events.addSuccess('Custom success message');
/// ```
class ResolverEventController {
  static ResolverEventController? _instance;
  // Avoid self instance
  ResolverEventController._();

  /// **Gets the singleton instance of the event controller**
  static ResolverEventController get events => _instance ??= ResolverEventController._();

  final StreamController<IResolverEvent> _eventController = StreamController<IResolverEvent>.broadcast();

  /// **The internal event stream**
  Stream<IResolverEvent> get eventStream => _eventController.stream;

  /// **Current configuration for automatic event registration**
  ResolverEventConfig _config = const ResolverEventConfig();

  /// **Gets the current configuration**
  ResolverEventConfig get config => _config;

  /// **Test override for event controller (internal use only)**
  static StreamController<IResolverEvent>? _testOverride;

  /// **Configures automatic event registration**
  ///
  /// Updates the configuration to enable or disable automatic registration
  /// of success and failure events.
  ///
  /// ## Parameters
  /// - [autoSuccess]: Whether to automatically register success events
  /// - [autoError]: Whether to automatically register failure events
  ///
  /// ## Example
  /// ```dart
  /// // Enable only success events
  /// ResolverEventController.events.configure(autoSuccess: true);
  ///
  /// // Enable both success and error events
  /// ResolverEventController.events.configure(
  ///   autoSuccess: true,
  ///   autoError: true,
  /// );
  /// ```
  void configure({bool? autoSuccess, bool? autoError}) {
    _config = ResolverEventConfig(autoSuccess: autoSuccess ?? _config.autoSuccess, autoError: autoError ?? _config.autoError);
  }

  /// **Configures using a ResolverEventConfig instance**
  ///
  /// Updates the configuration using a pre-built configuration object.
  ///
  /// ## Parameters
  /// - [config]: The configuration to apply
  ///
  /// ## Example
  /// ```dart
  /// final config = ResolverEventConfig(autoSuccess: true, autoError: true);
  /// ResolverEventController.events.configureWith(config);
  /// ```
  void configureWith(ResolverEventConfig config) {
    _config = config;
  }

  /// **Adds an event to the event stream**
  ///
  /// Low-level method to add any type of event to the stream.
  /// Most users should use the specific methods like [addSuccess], [addFailure], etc.
  ///
  /// ## Parameters
  /// - [event]: The event to add to the stream
  ///
  /// ## Example
  /// ```dart
  /// final event = ResolverEvent.success('Custom success');
  /// ResolverEventController.events.addEvent(event);
  /// ```
  void addEvent(IResolverEvent event) {
    // Use test override if available, otherwise use normal controller
    if (_testOverride != null) {
      _testOverride!.add(event);
    } else {
      _eventController.add(event);
    }
  }

  /// **Adds a success event to the stream**
  ///
  /// Creates and adds a success event with the provided message and optional metadata.
  ///
  /// ## Parameters
  /// - [message]: The success message
  /// - [metadata]: Optional metadata to include with the event
  ///
  /// ## Example
  /// ```dart
  /// ResolverEventController.events.addSuccess(
  ///   'User data loaded successfully',
  ///   metadata: {'userId': '123', 'loadTime': '150ms'},
  /// );
  /// ```
  void addSuccess(String message, {Map<String, dynamic>? metadata}) {
    addEvent(ResolverEvent.success(message, metadata: metadata));
  }

  /// **Adds a failure event to the stream**
  ///
  /// Creates and adds a failure event with the provided message and optional metadata.
  ///
  /// ## Parameters
  /// - [message]: The failure message
  /// - [metadata]: Optional metadata to include with the event
  ///
  /// ## Example
  /// ```dart
  /// ResolverEventController.events.addFailure(
  ///   'Failed to load user data',
  ///   metadata: {'error': 'NetworkException', 'retryCount': 3},
  /// );
  /// ```
  void addFailure(String message, {Map<String, dynamic>? metadata}) {
    addEvent(ResolverEvent.failure(message, metadata: metadata));
  }

  /// **Adds a history event to the stream**
  ///
  /// Creates and adds a history event with the provided message and optional metadata.
  /// History events are typically used for user actions and navigation tracking.
  ///
  /// ## Parameters
  /// - [message]: The history message
  /// - [metadata]: Optional metadata to include with the event
  ///
  /// ## Example
  /// ```dart
  /// ResolverEventController.events.addHistory(
  ///   'User clicked login button',
  ///   metadata: {'screen': 'LoginScreen', 'timestamp': DateTime.now().toIso8601String()},
  /// );
  /// ```
  void addHistory(String message, {Map<String, dynamic>? metadata}) {
    addEvent(ResolverEvent.history(message, metadata: metadata));
  }

  /// **Main method for listening to events with subscriber**
  ///
  /// This is the primary way to listen to resolver events. It provides an
  /// [EventSubscriber] that allows filtering events by type.
  ///
  /// ## Parameters
  /// - [callback]: Function that receives an EventSubscriber for setting up listeners
  ///
  /// ## Example
  /// ```dart
  /// ResolverEventController.events.listen((subscriber) {
  ///   subscriber.onSuccess((event) {
  ///     print('✅ ${event.message}');
  ///     analytics.trackSuccess(event.metadata);
  ///   });
  ///
  ///   subscriber.onFailure((event) {
  ///     print('❌ ${event.message}');
  ///     errorReporting.reportError(event.metadata);
  ///   });
  ///
  ///   subscriber.onHistory((event) {
  ///     print('📝 ${event.message}');
  ///     userBehaviorTracking.track(event.metadata);
  ///   });
  /// });
  /// ```
  void listen(void Function(EventSubscriber subscriber) callback) {
    final subscriber = EventSubscriber(eventStream);
    callback(subscriber);
  }

  /// **Automatically registers a success event (internal use)**
  ///
  /// This method is called internally by Resolver methods when auto-registration
  /// is enabled. Only registers the event if [autoSuccess] is true in the configuration.
  ///
  /// ## Parameters
  /// - [message]: The success message
  /// - [metadata]: Optional metadata to include with the event
  ///
  /// ⚠️ **Internal Use**: This method is intended for internal use by the Resolver class.
  void autoRegisterSuccess(String message, {Map<String, dynamic>? metadata}) {
    if (_config.autoSuccess) {
      addSuccess(message, metadata: metadata);
    }
  }

  /// **Automatically registers a failure event (internal use)**
  ///
  /// This method is called internally by Resolver methods when auto-registration
  /// is enabled. Only registers the event if [autoError] is true in the configuration.
  ///
  /// ## Parameters
  /// - [message]: The failure message
  /// - [metadata]: Optional metadata to include with the event
  ///
  /// ⚠️ **Internal Use**: This method is intended for internal use by the Resolver class.
  void autoRegisterFailure(String message, {Map<String, dynamic>? metadata}) {
    if (_config.autoError) {
      addFailure(message, metadata: metadata);
    }
  }

  bool _initialized = false;

  /// **Initializes the event controller**
  ///
  /// Called internally to set up the event controller. This method is idempotent
  /// and can be called multiple times safely.
  void initialize() {
    if (_initialized) return;
    _initialized = true;
  }

  /// **Disposes the event controller**
  ///
  /// Cleans up resources and resets the initialization state.
  /// Called when the controller is no longer needed.
  void dispose() {
    _initialized = false;
  }

  /// **Sets test override for event controller (testing only)**
  ///
  /// ⚠️ **Internal Use**: This method is intended for testing purposes only.
  static void setTestOverride(StreamController<IResolverEvent>? controller) {
    _testOverride = controller;
  }
}

/// **Example usage of the ResolverEventController**
///
/// This demonstrates the basic usage pattern for listening to resolver events.
void main() {
  ResolverEventController.events.listen((subscriber) {
    subscriber.onSuccess((event) {
      print('Success: ${event.message}');
    });
    subscriber.onFailure((event) {
      print('Failure: ${event.message}');
    });
    subscriber.onHistory((event) {
      print('History: ${event.message}');
    });
  });
}
