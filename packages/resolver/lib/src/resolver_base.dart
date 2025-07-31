import 'events/resolver_event_controller.dart';

/// **Resolver Pattern Implementation for PaipFood**
///
/// Provides a type-safe way to handle success and failure states
/// without throwing exceptions, perfect for microfront-end architecture.
///
/// ## Features
/// - Type-safe error handling
/// - Functional composition
/// - Automatic event logging
/// - Zero runtime overhead
///
/// ## Example
/// ```dart
/// final result = await Result.fromFuture(apiCall());
/// result.when(
///   onSuccess: (data) => print('Got: $data'),
///   onFailure: (error) => print('Error: $error'),
/// );
/// ```
sealed class Resolver<T, E> {
  const Resolver._();

  /// **Creates a successful result**
  ///
  /// Returns a [Success] instance containing the provided [value].
  ///
  /// ## Example
  /// ```dart
  /// final result = Resolver.success('Hello World');
  /// print(result.value); // 'Hello World'
  /// ```
  const factory Resolver.success(T value) = Success<T, E>;

  /// **Creates a failure result**
  ///
  /// Returns a [Failure] instance containing the provided [error].
  ///
  /// ## Example
  /// ```dart
  /// final result = Resolver.failure('Something went wrong');
  /// print(result.error); // 'Something went wrong'
  /// ```
  const factory Resolver.failure(E error) = Failure<T, E>;

  /// **Returns true if this is a success result**
  ///
  /// ## Example
  /// ```dart
  /// final result = Resolver.success('data');
  /// print(result.isSuccess); // true
  /// ```
  bool get isSuccess => this is Success<T, E>;

  /// **Returns true if this is a failure result**
  ///
  /// ## Example
  /// ```dart
  /// final result = Resolver.failure('error');
  /// print(result.isFailure); // true
  /// ```
  bool get isFailure => this is Failure<T, E>;

  /// **Gets the success value or null if failure**
  ///
  /// Safe way to access the value without throwing exceptions.
  ///
  /// ## Example
  /// ```dart
  /// final result = Resolver.success('data');
  /// final value = result.valueOrNull; // 'data'
  /// ```
  T? get valueOrNull => switch (this) {
    Success<T, E>(value: final value) => value,
    Failure<T, E>() => null,
  };

  /// **Gets the error or null if success**
  ///
  /// Safe way to access the error without throwing exceptions.
  ///
  /// ## Example
  /// ```dart
  /// final result = Resolver.failure('error');
  /// final error = result.errorOrNull; // 'error'
  /// ```
  E? get errorOrNull => switch (this) {
    Success<T, E>() => null,
    Failure<T, E>(error: final error) => error,
  };

  /// **Gets the success value or throws exception if failure**
  ///
  /// ⚠️ **Warning**: This method throws [ResultException] if called on a failure result.
  /// Use [valueOrNull] for safe access.
  ///
  /// ## Example
  /// ```dart
  /// final result = Resolver.success('data');
  /// print(result.value); // 'data'
  /// ```
  T get value => switch (this) {
    Success<T, E>(value: final value) => value,
    Failure<T, E>(error: final error) => throw ResultException('Attempted to get value from failure result: $error'),
  };

  /// **Gets the error or throws exception if success**
  ///
  /// ⚠️ **Warning**: This method throws [ResultException] if called on a success result.
  /// Use [errorOrNull] for safe access.
  ///
  /// ## Example
  /// ```dart
  /// final result = Resolver.failure('error');
  /// print(result.error); // 'error'
  /// ```
  E get error => switch (this) {
    Success<T, E>(value: final value) => throw ResultException('Attempted to get error from success result: $value'),
    Failure<T, E>(error: final error) => error,
  };

  /// **Pattern matching - executes the appropriate callback**
  ///
  /// Executes [onSuccess] if this is a success result, or [onFailure] if this is a failure result.
  /// Returns the result of the executed callback.
  ///
  /// ## Parameters
  /// - [onSuccess]: Callback executed for success results
  /// - [onFailure]: Callback executed for failure results
  ///
  /// ## Example
  /// ```dart
  /// final message = result.when(
  ///   onSuccess: (value) => 'Success: $value',
  ///   onFailure: (error) => 'Error: $error',
  /// );
  /// ```
  R when<R>({required R Function(T value) onSuccess, required R Function(E error) onFailure}) {
    return switch (this) {
      Success<T, E>(value: final value) => onSuccess(value),
      Failure<T, E>(error: final error) => onFailure(error),
    };
  }

  /// **Pattern matching with void callbacks**
  ///
  /// Similar to [when] but for side effects that don't return values.
  ///
  /// ## Parameters
  /// - [onSuccess]: Callback executed for success results
  /// - [onFailure]: Callback executed for failure results
  ///
  /// ## Example
  /// ```dart
  /// result.whenVoid(
  ///   onSuccess: (value) => print('Got: $value'),
  ///   onFailure: (error) => print('Error: $error'),
  /// );
  /// ```
  void whenVoid({required void Function(T value) onSuccess, required void Function(E error) onFailure}) {
    switch (this) {
      case Success<T, E>(value: final value):
        onSuccess(value);
      case Failure<T, E>(error: final error):
        onFailure(error);
    }
  }

  /// **Maps the success value to another type**
  ///
  /// If this is a success result, applies [mapper] to the value and returns a new success result.
  /// If this is a failure result, returns the failure unchanged.
  ///
  /// ## Parameters
  /// - [mapper]: Function to transform the success value
  ///
  /// ## Example
  /// ```dart
  /// final result = Resolver.success('hello');
  /// final mapped = result.map((s) => s.toUpperCase()); // Success('HELLO')
  /// ```
  Resolver<R, E> map<R>(R Function(T value) mapper) {
    return switch (this) {
      Success<T, E>(value: final value) => Resolver.success(mapper(value)),
      Failure<T, E>(error: final error) => Resolver.failure(error),
    };
  }

  /// **Maps the error to another type**
  ///
  /// If this is a failure result, applies [mapper] to the error and returns a new failure result.
  /// If this is a success result, returns the success unchanged.
  ///
  /// ## Parameters
  /// - [mapper]: Function to transform the error
  ///
  /// ## Example
  /// ```dart
  /// final result = Resolver.failure('error');
  /// final mapped = result.mapError((e) => 'Mapped: $e'); // Failure('Mapped: error')
  /// ```
  Resolver<T, R> mapError<R>(R Function(E error) mapper) {
    return switch (this) {
      Success<T, E>(value: final value) => Resolver.success(value),
      Failure<T, E>(error: final error) => Resolver.failure(mapper(error)),
    };
  }

  /// **Flat map of the success value (chains operations)**
  ///
  /// If this is a success result, applies [mapper] to the value and returns the result.
  /// If this is a failure result, returns the failure unchanged.
  /// Perfect for chaining operations that can also fail.
  ///
  /// ## Parameters
  /// - [mapper]: Function that returns another Resolver
  ///
  /// ## Example
  /// ```dart
  /// final result = Resolver.success('123');
  /// final parsed = result.flatMap((s) =>
  ///   Resolver.from(() => int.parse(s), onError: (e) => 'Invalid number')
  /// ); // Success(123)
  /// ```
  Resolver<R, E> flatMap<R>(Resolver<R, E> Function(T value) mapper) {
    return switch (this) {
      Success<T, E>(value: final value) => mapper(value),
      Failure<T, E>(error: final error) => Resolver.failure(error),
    };
  }

  /// **Asynchronous flat map**
  ///
  /// Similar to [flatMap] but for asynchronous operations.
  ///
  /// ## Parameters
  /// - [mapper]: Function that returns a Future<Resolver>
  ///
  /// ## Example
  /// ```dart
  /// final result = await resolver.flatMapAsync((value) async {
  ///   return await Resolver.fromFutureSimple(
  ///     apiCall(value),
  ///     onError: (e) => 'API call failed',
  ///   );
  /// });
  /// ```
  Future<Resolver<R, E>> flatMapAsync<R>(Future<Resolver<R, E>> Function(T value) mapper) async {
    return switch (this) {
      Success<T, E>(value: final value) => await mapper(value),
      Failure<T, E>(error: final error) => Resolver.failure(error),
    };
  }

  /// **Filters the success value**
  ///
  /// If this is a success result and [predicate] returns true, returns the success unchanged.
  /// If this is a success result and [predicate] returns false, returns a failure.
  /// If this is already a failure result, returns the failure unchanged.
  ///
  /// ## Parameters
  /// - [predicate]: Function to test the success value
  /// - [onFilterFailed]: Function to create error when filter fails
  ///
  /// ## Example
  /// ```dart
  /// final result = Resolver.success(5);
  /// final filtered = result.filter(
  ///   (n) => n > 10,
  ///   () => 'Number too small',
  /// ); // Failure('Number too small')
  /// ```
  Resolver<T, E> filter(bool Function(T value) predicate, E Function() onFilterFailed) {
    return switch (this) {
      Success<T, E>(value: final value) => predicate(value) ? Resolver.success(value) : Resolver.failure(onFilterFailed()),
      Failure<T, E>(error: final error) => Resolver.failure(error),
    };
  }

  /// **Returns the success value or a default value**
  ///
  /// If this is a success result, returns the value.
  /// If this is a failure result, returns the result of [defaultValue].
  ///
  /// ## Parameters
  /// - [defaultValue]: Function that provides the default value
  ///
  /// ## Example
  /// ```dart
  /// final result = Resolver.failure('error');
  /// final value = result.getOrElse(() => 'default'); // 'default'
  /// ```
  T getOrElse(T Function() defaultValue) {
    return switch (this) {
      Success<T, E>(value: final value) => value,
      Failure<T, E>() => defaultValue(),
    };
  }

  /// **Returns this result if success, otherwise returns the alternative**
  ///
  /// If this is a success result, returns this result.
  /// If this is a failure result, returns the result of [alternative].
  ///
  /// ## Parameters
  /// - [alternative]: Function that provides an alternative result
  ///
  /// ## Example
  /// ```dart
  /// final result = Resolver.failure('error');
  /// final alternative = result.orElse(() => Resolver.success('backup')); // Success('backup')
  /// ```
  Resolver<T, E> orElse(Resolver<T, E> Function() alternative) {
    return switch (this) {
      Success<T, E>() => this,
      Failure<T, E>() => alternative(),
    };
  }

  /// **Combines two results into a tuple**
  ///
  /// If both this and [other] are success results, returns a success with a tuple of both values.
  /// If either is a failure result, returns the first failure encountered.
  ///
  /// ## Parameters
  /// - [other]: Another result to combine with this one
  ///
  /// ## Example
  /// ```dart
  /// final result1 = Resolver.success('hello');
  /// final result2 = Resolver.success(42);
  /// final combined = result1.zip(result2); // Success(('hello', 42))
  /// ```
  Resolver<(T, R), E> zip<R>(Resolver<R, E> other) {
    return switch ((this, other)) {
      (Success<T, E>(value: final value1), Success<R, E>(value: final value2)) => Resolver.success((value1, value2)),
      (Failure<T, E>(error: final error), _) => Resolver.failure(error),
      (_, Failure<R, E>(error: final error)) => Resolver.failure(error),
    };
  }

  /// **Executes a side effect if success**
  ///
  /// If this is a success result, executes [callback] with the value.
  /// Returns this result unchanged (useful for chaining).
  ///
  /// ## Parameters
  /// - [callback]: Function to execute for side effects
  ///
  /// ## Example
  /// ```dart
  /// final result = Resolver.success('data')
  ///   .onSuccess((value) => print('Got: $value'))
  ///   .map((s) => s.toUpperCase());
  /// ```
  Resolver<T, E> onSuccess(void Function(T value) callback) {
    if (this case Success<T, E>(value: final value)) {
      callback(value);
    }
    return this;
  }

  /// **Executes a side effect if failure**
  ///
  /// If this is a failure result, executes [callback] with the error.
  /// Returns this result unchanged (useful for chaining).
  ///
  /// ## Parameters
  /// - [callback]: Function to execute for side effects
  ///
  /// ## Example
  /// ```dart
  /// final result = Resolver.failure('error')
  ///   .onFailure((error) => print('Error: $error'))
  ///   .orElse(() => Resolver.success('backup'));
  /// ```
  Resolver<T, E> onFailure(void Function(E error) callback) {
    if (this case Failure<T, E>(error: final error)) {
      callback(error);
    }
    return this;
  }

  /// **Converts to Future<T> throwing exception on failure**
  ///
  /// If this is a success result, returns a Future with the value.
  /// If this is a failure result, returns a Future that throws [ResultException].
  ///
  /// ⚠️ **Warning**: This method can throw exceptions. Use only when integrating
  /// with APIs that expect Futures.
  ///
  /// ## Example
  /// ```dart
  /// try {
  ///   final value = await result.toFuture();
  ///   print('Value: $value');
  /// } catch (e) {
  ///   print('Error: $e');
  /// }
  /// ```
  Future<T> toFuture() async {
    return switch (this) {
      Success<T, E>(value: final value) => value,
      Failure<T, E>(error: final error) => throw ResultException('Result failed: $error'),
    };
  }

  @override
  String toString() => switch (this) {
    Success<T, E>(value: final value) => 'Success($value)',
    Failure<T, E>(error: final error) => 'Failure($error)',
  };

  @override
  bool operator ==(Object other) {
    return switch ((this, other)) {
      (Success<T, E>(value: final value1), Success<T, E>(value: final value2)) => value1 == value2,
      (Failure<T, E>(error: final error1), Failure<T, E>(error: final error2)) => error1 == error2,
      _ => false,
    };
  }

  @override
  int get hashCode => switch (this) {
    Success<T, E>(value: final value) => Object.hash('Success', value),
    Failure<T, E>(error: final error) => Object.hash('Failure', error),
  };

  // ============================================================================
  // SIMPLE UTILITIES - For Exception-based results
  // ============================================================================
}

/// **Success result implementation**
///
/// Represents a successful operation result containing a [value] of type [T].
final class Success<T, E> extends Resolver<T, E> {
  const Success(this.value) : super._();

  @override
  final T value;
}

/// **Failure result implementation**
///
/// Represents a failed operation result containing an [error] of type [E].
final class Failure<T, E> extends Resolver<T, E> {
  const Failure(this.error) : super._();

  @override
  final E error;
}

/// **Exception thrown when accessing incorrect result state**
///
/// Thrown when trying to access [value] on a failure result or [error] on a success result.
class ResultException implements Exception {
  const ResultException(this.message);

  final String message;

  @override
  String toString() => 'ResultException: $message';
}

/// **Convenience function to create a success result**
///
/// ## Example
/// ```dart
/// final result = success<String, Exception>('Hello');
/// ```
Resolver<T, E> success<T, E>(T value) => Resolver.success(value);

/// **Convenience function to create a failure result**
///
/// ## Example
/// ```dart
/// final result = failure<String, Exception>(Exception('Error'));
/// ```
Resolver<T, E> failure<T, E>(E error) => Resolver.failure(error);

/// **Result class with Exception as default error type**
///
/// Provides simplified methods for common use cases where error type is always Exception.
/// Perfect when you don't need custom error types.
///
/// ## Example
/// ```dart
/// final result = Result.success('value');
/// final asyncResult = await Result.fromFuture(someOperation());
/// ```
abstract class Result {
  /// **Creates a successful result**
  static Resolver<T, Exception> success<T>(T value) => Resolver.success(value);

  /// **Creates a failure result with Exception**
  static Resolver<T, Exception> failure<T>(Exception error) => Resolver.failure(error);

  /// **Creates a Result from a Future with Exception as error type**
  static Future<Resolver<T, Exception>> fromFuture<T>(Future<T> future, {String Function(Object error)? onError}) async {
    try {
      final value = await future;
      final result = Resolver<T, Exception>.success(value);

      // Auto-register success event if enabled
      if (ResolverEventController.events.config.autoSuccess) {
        ResolverEventController.events.addSuccess('Simple future executed successfully', metadata: {'type': T.toString(), 'source': 'fromFutureSimple'});
      }

      return result;
    } catch (error) {
      final message = onError?.call(error) ?? error.toString();
      final result = Resolver<T, Exception>.failure(Exception(message));

      // Auto-register failure event if enabled
      if (ResolverEventController.events.config.autoError) {
        ResolverEventController.events.addFailure('Simple future failed', metadata: {'type': 'dynamic', 'source': 'fromFutureSimple', 'originalError': error, 'errorMessage': message});
      }

      return result;
    }
  }

  /// **Creates a Result from a synchronous operation with Exception as error type**
  static Resolver<T, Exception> from<T>(T Function() operation, {String Function(Object error)? onError}) {
    try {
      final value = operation();
      return Resolver.success(value);
    } catch (error) {
      final message = onError?.call(error) ?? error.toString();
      return Resolver.failure(Exception(message));
    }
  }
}

/// **Asynchronous Result type**
///
/// Represents a Future that resolves to a Resolver with Exception as error type.
///
/// ## Example
/// ```dart
/// AsyncResult<String> fetchData() async {
///   return await Result.fromFuture(httpClient.get('/data'));
/// }
/// ```
typedef AsyncResult<T> = Future<Resolver<T, Exception>>;

/// **Asynchronous Resolver type**
///
/// Represents a Future that resolves to a Resolver with custom error type.
///
/// ## Example
/// ```dart
/// AsyncResolver<User, ApiError> fetchUser(String id) async {
///   return await Resolver.fromFuture(
///     userService.getUser(id),
///     (error, stackTrace) => ApiError.fromException(error),
///   );
/// }
/// ```
typedef AsyncResolver<T, E> = Future<Resolver<T, E>>;

// ============================================================================
// GLOBAL SUCCESS AND FAILURE FUNCTIONS - For direct usage
// ============================================================================

/// **Global Success function for direct usage**
///
/// Creates a success result directly without prefixes.
/// Returns a Resolver<T, Exception> for compatibility with the Result pattern.
///
/// ## Example
/// ```dart
/// return Ok('Hello World');
/// return Ok(42);
/// return Ok(['item1', 'item2']);
/// ```
Resolver<T, Exception> Ok<T>(T value) => Resolver.success(value);

/// **Global Failure function for direct usage**
///
/// Creates a failure result directly without prefixes.
/// Automatically wraps strings in Exception objects for convenience.
/// Returns a Resolver<T, Exception> for compatibility with the Result pattern.
///
/// ## Examples
/// ```dart
/// return Err('Something went wrong');        // String -> Exception
/// return Err(Exception('Custom error'));     // Direct Exception
/// return Err(MyCustomException('Error'));    // Any Exception type
/// ```
Resolver<T, Exception> Err<T>(Object error) {
  if (error is Exception) {
    return Resolver.failure(error);
  } else {
    return Resolver.failure(Exception(error.toString()));
  }
}

/// **Convenience function to create a simple success result**
///
/// Creates a Resolver<T, Exception> containing the provided value.
///
/// ## Example
/// ```dart
/// final result = simpleSuccess('Hello World');
/// ```
Resolver<T, Exception> simpleSuccess<T>(T value) => Resolver.success(value);

/// **Convenience function to create a simple failure result**
///
/// Creates a Resolver<T, Exception> containing an Exception with the provided message.
///
/// ## Example
/// ```dart
/// final result = simpleFailure<String>('Something went wrong');
/// ```
Resolver<T, Exception> simpleFailure<T>(String message) => Resolver.failure(Exception(message));
