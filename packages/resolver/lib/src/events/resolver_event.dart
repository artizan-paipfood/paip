/// **Enumeration of resolver event types**
///
/// Defines the different types of events that can be emitted by the resolver system.
///
/// ## Values
/// - [success]: Indicates a successful operation
/// - [failure]: Indicates a failed operation
/// - [history]: Indicates a user action or navigation event
///
/// ## Example
/// ```dart
/// final eventType = ResolverEventType.success;
/// print(eventType); // ResolverEventType.success
/// ```
enum ResolverEventType { success, failure, history }

/// **Abstract interface for resolver events**
///
/// Defines the contract that all resolver events must implement.
/// Contains basic information about when the event occurred, what type it is,
/// and any associated message or metadata.
///
/// ## Properties
/// - [timestamp]: When the event occurred
/// - [eventType]: The type of event (success, failure, history)
/// - [message]: Human-readable description of the event
/// - [metadata]: Optional additional data associated with the event
///
/// ## Example
/// ```dart
/// class CustomEvent extends IResolverEvent {
///   CustomEvent(String message) : super(
///     timestamp: DateTime.now(),
///     eventType: ResolverEventType.success,
///     message: message,
///   );
/// }
/// ```
abstract class IResolverEvent {
  const IResolverEvent({required this.timestamp, required this.eventType, required this.message, this.metadata = const {}});

  /// **Timestamp when the event occurred**
  ///
  /// Records the exact moment when this event was created.
  /// Useful for debugging, analytics, and event ordering.
  final DateTime timestamp;

  /// **Type of the resolver event**
  ///
  /// Indicates whether this is a success, failure, or history event.
  /// Used for filtering and routing events to appropriate handlers.
  final ResolverEventType eventType;

  /// **Human-readable message describing the event**
  ///
  /// Provides context about what happened when this event was created.
  /// Should be descriptive enough for debugging and logging purposes.
  final String message;

  /// **Optional metadata associated with the event**
  ///
  /// Can contain any additional information relevant to the event,
  /// such as error details, performance metrics, or user context.
  ///
  /// ## Example
  /// ```dart
  /// final metadata = {
  ///   'userId': '123',
  ///   'operation': 'fetchUserData',
  ///   'duration': '150ms',
  ///   'cacheHit': true,
  /// };
  /// ```
  final Map<String, dynamic>? metadata;

  /// **Converts the event to a JSON representation**
  ///
  /// Serializes the event data to a Map that can be easily converted to JSON.
  /// Useful for logging, analytics, and debugging.
  ///
  /// ## Returns
  /// A Map containing the event's timestamp, type, and metadata.
  ///
  /// ## Example
  /// ```dart
  /// final event = ResolverEvent.success('Operation completed');
  /// final json = event.toJson();
  /// print(json); // {'timestamp': '2023-...', 'eventType': 'success', 'metadata': {}}
  /// ```
  Map<String, dynamic> toJson() => {'timestamp': timestamp.toIso8601String(), 'eventType': eventType.name, 'message': message, 'metadata': metadata};

  @override
  String toString() => 'ResolverEvent(${eventType.name} at ${timestamp.toIso8601String()}): $message';
}

/// **Concrete implementation of a resolver event**
///
/// The standard implementation of [IResolverEvent] that automatically sets
/// the timestamp to the current time when created.
///
/// ## Factory Methods
/// - [ResolverEvent.success]: Creates a success event
/// - [ResolverEvent.failure]: Creates a failure event
/// - [ResolverEvent.history]: Creates a history event
///
/// ## Example
/// ```dart
/// // Manual creation
/// final event = ResolverEvent(
///   eventType: ResolverEventType.success,
///   message: 'Data loaded successfully',
///   metadata: {'loadTime': '200ms'},
/// );
///
/// // Using factory methods (recommended)
/// final successEvent = ResolverEvent.success('Operation completed');
/// final failureEvent = ResolverEvent.failure('Network error occurred');
/// final historyEvent = ResolverEvent.history('User clicked button');
/// ```
class ResolverEvent extends IResolverEvent {
  ResolverEvent({required super.eventType, required super.message, required super.metadata}) : super(timestamp: DateTime.now());

  /// **Factory method to create a success event**
  ///
  /// Creates a new success event with the current timestamp.
  ///
  /// ## Parameters
  /// - [message]: Description of the successful operation
  /// - [metadata]: Optional additional data about the success
  ///
  /// ## Example
  /// ```dart
  /// final event = ResolverEvent.success(
  ///   'User data fetched successfully',
  ///   metadata: {
  ///     'userId': '123',
  ///     'fetchTime': '150ms',
  ///     'cacheHit': false,
  ///   },
  /// );
  /// ```
  factory ResolverEvent.success(String message, {Map<String, dynamic>? metadata}) => ResolverEvent(eventType: ResolverEventType.success, message: message, metadata: metadata);

  /// **Factory method to create a failure event**
  ///
  /// Creates a new failure event with the current timestamp.
  ///
  /// ## Parameters
  /// - [message]: Description of what went wrong
  /// - [metadata]: Optional additional data about the failure
  ///
  /// ## Example
  /// ```dart
  /// final event = ResolverEvent.failure(
  ///   'Failed to connect to server',
  ///   metadata: {
  ///     'errorCode': 'NETWORK_ERROR',
  ///     'retryCount': 3,
  ///     'lastAttempt': DateTime.now().toIso8601String(),
  ///   },
  /// );
  /// ```
  factory ResolverEvent.failure(String message, {Map<String, dynamic>? metadata}) => ResolverEvent(eventType: ResolverEventType.failure, message: message, metadata: metadata);

  /// **Factory method to create a history event**
  ///
  /// Creates a new history event with the current timestamp.
  /// History events are typically used for user actions and navigation tracking.
  ///
  /// ## Parameters
  /// - [message]: Description of the user action or navigation
  /// - [metadata]: Optional additional data about the action
  ///
  /// ## Example
  /// ```dart
  /// final event = ResolverEvent.history(
  ///   'User navigated to profile screen',
  ///   metadata: {
  ///     'fromScreen': 'HomeScreen',
  ///     'toScreen': 'ProfileScreen',
  ///     'userId': '123',
  ///     'sessionId': 'abc-123',
  ///   },
  /// );
  /// ```
  factory ResolverEvent.history(String message, {Map<String, dynamic>? metadata}) => ResolverEvent(eventType: ResolverEventType.history, message: message, metadata: metadata);
}
