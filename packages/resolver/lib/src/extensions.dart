import 'package:resolver/resolver.dart';

/// **Extensions for Future<Resolver>**
///
/// Provides additional functionality for working with asynchronous Resolver operations.
/// These extensions make it easier to chain operations and handle asynchronous transformations.
///
/// ## Example
/// ```dart
/// final result = await fetchUserData()
///   .mapAsync((user) => fetchUserPreferences(user.id))
///   .onSuccessAsync((prefs) => cachePreferences(prefs));
/// ```
extension FutureResultExtensions<T, E> on Future<Resolver<T, E>> {
  /// **Maps the success value asynchronously**
  ///
  /// If the result is successful, applies the asynchronous [mapper] function to the value.
  /// If the result is a failure, returns the failure unchanged.
  ///
  /// ## Parameters
  /// - [mapper]: Asynchronous function to transform the success value
  ///
  /// ## Example
  /// ```dart
  /// final result = await fetchUserId()
  ///   .mapAsync((id) async => await fetchUserName(id));
  /// ```
  Future<Resolver<R, E>> mapAsync<R>(Future<R> Function(T value) mapper) async {
    final result = await this;
    return switch (result) {
      Success<T, E>(value: final value) => Resolver.success(await mapper(value)),
      Failure<T, E>(error: final error) => Resolver.failure(error),
    };
  }

  /// **Asynchronous flat map**
  ///
  /// If the result is successful, applies the asynchronous [mapper] function that returns another Resolver.
  /// If the result is a failure, returns the failure unchanged.
  /// Perfect for chaining asynchronous operations that can also fail.
  ///
  /// ## Parameters
  /// - [mapper]: Asynchronous function that returns a Future<Resolver>
  ///
  /// ## Example
  /// ```dart
  /// final result = await fetchUser()
  ///   .flatMapAsync((user) async => await validateUserPermissions(user));
  /// ```
  Future<Resolver<R, E>> flatMapAsync<R>(Future<Resolver<R, E>> Function(T value) mapper) async {
    final result = await this;
    return await result.flatMapAsync(mapper);
  }

  /// **Executes an asynchronous callback on success**
  ///
  /// If the result is successful, executes the asynchronous [callback] with the value.
  /// Returns the original result unchanged (useful for chaining).
  ///
  /// ## Parameters
  /// - [callback]: Asynchronous function to execute for side effects
  ///
  /// ## Example
  /// ```dart
  /// final result = await fetchUserData()
  ///   .onSuccessAsync((user) async => await logUserActivity(user))
  ///   .mapAsync((user) => user.name);
  /// ```
  Future<Resolver<T, E>> onSuccessAsync(Future<void> Function(T value) callback) async {
    final result = await this;
    if (result case Success<T, E>(value: final value)) {
      await callback(value);
    }
    return result;
  }

  /// **Executes an asynchronous callback on failure**
  ///
  /// If the result is a failure, executes the asynchronous [callback] with the error.
  /// Returns the original result unchanged (useful for chaining).
  ///
  /// ## Parameters
  /// - [callback]: Asynchronous function to execute for side effects
  ///
  /// ## Example
  /// ```dart
  /// final result = await fetchUserData()
  ///   .onFailureAsync((error) async => await reportError(error))
  ///   .orElse(() => Resolver.success(defaultUser));
  /// ```
  Future<Resolver<T, E>> onFailureAsync(Future<void> Function(E error) callback) async {
    final result = await this;
    if (result case Failure<T, E>(error: final error)) {
      await callback(error);
    }
    return result;
  }
}

/// **Extensions for List<Resolver>**
///
/// Provides utility methods for working with collections of Resolver results.
/// Useful for aggregating multiple operations and extracting specific result types.
///
/// ## Example
/// ```dart
/// final results = [
///   Resolver.success('user1'),
///   Resolver.failure('error'),
///   Resolver.success('user2'),
/// ];
///
/// final successes = results.successes(); // ['user1', 'user2']
/// final failures = results.failures(); // ['error']
/// ```
extension ListResultExtensions<T, E> on List<Resolver<T, E>> {
  /// **Combines all results into a single result**
  ///
  /// Returns a success with all values if all results are successful.
  /// Returns the first failure if any result fails.
  /// This is useful for "all or nothing" operations.
  ///
  /// ## Returns
  /// - Success with List<T> if all results are successful
  /// - First failure encountered if any result fails
  ///
  /// ## Example
  /// ```dart
  /// final results = [
  ///   Resolver.success(1),
  ///   Resolver.success(2),
  ///   Resolver.success(3),
  /// ];
  ///
  /// final combined = results.sequence(); // Success([1, 2, 3])
  /// ```
  Resolver<List<T>, E> sequence() {
    final values = <T>[];
    for (final result in this) {
      switch (result) {
        case Success<T, E>(value: final value):
          values.add(value);
        case Failure<T, E>(error: final error):
          return Resolver.failure(error);
      }
    }
    return Resolver.success(values);
  }

  /// **Returns only the success values**
  ///
  /// Extracts all successful values from the list, ignoring failures.
  /// Useful when you want to process partial results.
  ///
  /// ## Returns
  /// List of all successful values
  ///
  /// ## Example
  /// ```dart
  /// final results = [
  ///   Resolver.success('user1'),
  ///   Resolver.failure('network error'),
  ///   Resolver.success('user2'),
  /// ];
  ///
  /// final users = results.successes(); // ['user1', 'user2']
  /// ```
  List<T> successes() {
    return [
      for (final result in this)
        if (result case Success<T, E>(value: final value)) value,
    ];
  }

  /// **Returns only the error values**
  ///
  /// Extracts all failure errors from the list, ignoring successes.
  /// Useful for error reporting and debugging.
  ///
  /// ## Returns
  /// List of all error values
  ///
  /// ## Example
  /// ```dart
  /// final results = [
  ///   Resolver.success('user1'),
  ///   Resolver.failure('network error'),
  ///   Resolver.failure('timeout'),
  /// ];
  ///
  /// final errors = results.failures(); // ['network error', 'timeout']
  /// ```
  List<E> failures() {
    return [
      for (final result in this)
        if (result case Failure<T, E>(error: final error)) error,
    ];
  }
}

/// **Additional extensions for the Resolver pattern**
///
/// These extensions provide additional utility methods for common use cases
/// and integration with nullable types and validation scenarios.

/// **Extensions for working with nullable values**
///
/// Provides convenient methods to convert nullable values into Resolver results.
///
/// ## Example
/// ```dart
/// String? maybeValue = getValue();
/// final result = maybeValue.toResult(() => 'Value is null');
/// ```
extension NullableResultExtensions<T, E> on T? {
  /// **Converts nullable value to Resolver**
  ///
  /// If the value is not null, returns a success result with the value.
  /// If the value is null, returns a failure result using the provided [onNull] function.
  ///
  /// ## Parameters
  /// - [onNull]: Function to create the error value when null
  ///
  /// ## Example
  /// ```dart
  /// String? userName = getUserName();
  /// final result = userName.toResult(() => 'User name not found');
  ///
  /// result.when(
  ///   onSuccess: (name) => print('Hello $name'),
  ///   onFailure: (error) => print('Error: $error'),
  /// );
  /// ```
  Resolver<T, E> toResult(E Function() onNull) {
    return this != null ? Resolver.success(this as T) : Resolver.failure(onNull());
  }
}

/// **Extensions for boolean values**
///
/// Provides methods to convert boolean conditions into Resolver results.
///
/// ## Example
/// ```dart
/// bool isValid = validateInput(input);
/// final result = isValid.toResult(() => 'Input is invalid');
/// ```
extension BoolResultExtensions<E> on bool {
  /// **Converts boolean to Resolver**
  ///
  /// If the boolean is true, returns a success result.
  /// If the boolean is false, returns a failure result using the provided [onFalse] function.
  ///
  /// ## Parameters
  /// - [onFalse]: Function to create the error value when false
  ///
  /// ## Example
  /// ```dart
  /// bool hasPermission = checkUserPermission();
  /// final result = hasPermission.toResult(() => 'Access denied');
  ///
  /// result.when(
  ///   onSuccess: (_) => proceedWithAction(),
  ///   onFailure: (error) => showError(error),
  /// );
  /// ```
  Resolver<void, E> toResult(E Function() onFalse) {
    return this ? Resolver.success(null) : Resolver.failure(onFalse());
  }
}

/// **Extensions for Resolver with void success type**
///
/// Provides utility methods for working with Resolver results that don't return values.
///
/// ## Example
/// ```dart
/// final result = performAction(); // Returns Resolver<void, String>
/// final mapped = result.mapTo('Action completed');
/// ```
extension UnitResultExtensions<E> on Resolver<void, E> {
  /// **Maps void result to another type**
  ///
  /// Converts a void success result to a result containing the provided [value].
  /// Useful for chaining operations after void operations.
  ///
  /// ## Parameters
  /// - [value]: Value to use for the success case
  ///
  /// ## Example
  /// ```dart
  /// final result = await saveUserData() // Returns Resolver<void, String>
  ///   .mapTo('Data saved successfully');
  ///
  /// print(result.value); // 'Data saved successfully'
  /// ```
  Resolver<T, E> mapTo<T>(T value) {
    return map((_) => value);
  }
}

/// **Extensions for String validation**
///
/// Provides common validation methods for String values that return Resolver results.
///
/// ## Example
/// ```dart
/// final email = 'user@example.com';
/// final result = email.validateEmail().validateNotEmpty();
/// ```
extension StringValidationExtensions on String {
  /// **Validates that string is not empty**
  ///
  /// Returns a success result if the string is not empty.
  /// Returns a failure result if the string is empty.
  ///
  /// ## Parameters
  /// - [errorMessage]: Optional custom error message
  ///
  /// ## Example
  /// ```dart
  /// final input = getUserInput();
  /// final result = input.validateNotEmpty('Input cannot be empty');
  ///
  /// result.when(
  ///   onSuccess: (value) => processInput(value),
  ///   onFailure: (error) => showValidationError(error),
  /// );
  /// ```
  Resolver<String, String> validateNotEmpty([String? errorMessage]) {
    return isEmpty ? Resolver.failure(errorMessage ?? 'String cannot be empty') : Resolver.success(this);
  }

  /// **Validates that string matches a pattern**
  ///
  /// Returns a success result if the string matches the provided [pattern].
  /// Returns a failure result if the string doesn't match.
  ///
  /// ## Parameters
  /// - [pattern]: Regular expression pattern to match
  /// - [errorMessage]: Optional custom error message
  ///
  /// ## Example
  /// ```dart
  /// final phoneNumber = '+1234567890';
  /// final phonePattern = RegExp(r'^\+\d{10,15}$');
  /// final result = phoneNumber.validatePattern(
  ///   phonePattern,
  ///   'Invalid phone number format',
  /// );
  /// ```
  Resolver<String, String> validatePattern(RegExp pattern, [String? errorMessage]) {
    return pattern.hasMatch(this) ? Resolver.success(this) : Resolver.failure(errorMessage ?? 'String does not match pattern');
  }

  /// **Validates email format**
  ///
  /// Returns a success result if the string is a valid email format.
  /// Returns a failure result if the email format is invalid.
  ///
  /// ## Parameters
  /// - [errorMessage]: Optional custom error message
  ///
  /// ## Example
  /// ```dart
  /// final email = 'user@example.com';
  /// final result = email.validateEmail();
  ///
  /// result.when(
  ///   onSuccess: (validEmail) => sendEmail(validEmail),
  ///   onFailure: (error) => showError(error),
  /// );
  /// ```
  Resolver<String, String> validateEmail([String? errorMessage]) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return validatePattern(emailRegex, errorMessage ?? 'Invalid email format');
  }
}

/// **Extensions for numeric validation**
///
/// Provides common validation methods for numeric values that return Resolver results.
///
/// ## Example
/// ```dart
/// final age = 25;
/// final result = age.validatePositive().validateRange(18, 100);
/// ```
extension NumValidationExtensions on num {
  /// **Validates that number is positive**
  ///
  /// Returns a success result if the number is greater than zero.
  /// Returns a failure result if the number is zero or negative.
  ///
  /// ## Parameters
  /// - [errorMessage]: Optional custom error message
  ///
  /// ## Example
  /// ```dart
  /// final amount = getUserAmount();
  /// final result = amount.validatePositive('Amount must be positive');
  ///
  /// result.when(
  ///   onSuccess: (validAmount) => processPayment(validAmount),
  ///   onFailure: (error) => showValidationError(error),
  /// );
  /// ```
  Resolver<num, String> validatePositive([String? errorMessage]) {
    return this > 0 ? Resolver.success(this) : Resolver.failure(errorMessage ?? 'Number must be positive');
  }

  /// **Validates that number is within a range**
  ///
  /// Returns a success result if the number is between [min] and [max] (inclusive).
  /// Returns a failure result if the number is outside the range.
  ///
  /// ## Parameters
  /// - [min]: Minimum allowed value (inclusive)
  /// - [max]: Maximum allowed value (inclusive)
  /// - [errorMessage]: Optional custom error message
  ///
  /// ## Example
  /// ```dart
  /// final age = getUserAge();
  /// final result = age.validateRange(18, 120, 'Age must be between 18 and 120');
  ///
  /// result.when(
  ///   onSuccess: (validAge) => createAccount(validAge),
  ///   onFailure: (error) => showAgeError(error),
  /// );
  /// ```
  Resolver<num, String> validateRange(num min, num max, [String? errorMessage]) {
    return this >= min && this <= max ? Resolver.success(this) : Resolver.failure(errorMessage ?? 'Number must be between $min and $max');
  }
}

/// **Extensions for List validation**
///
/// Provides common validation methods for List values that return Resolver results.
///
/// ## Example
/// ```dart
/// final items = getSelectedItems();
/// final result = items.validateNotEmpty().validateMinLength(2);
/// ```
extension ListValidationExtensions<T> on List<T> {
  /// **Validates that list is not empty**
  ///
  /// Returns a success result if the list contains at least one item.
  /// Returns a failure result if the list is empty.
  ///
  /// ## Parameters
  /// - [errorMessage]: Optional custom error message
  ///
  /// ## Example
  /// ```dart
  /// final selectedItems = getSelectedItems();
  /// final result = selectedItems.validateNotEmpty('Please select at least one item');
  ///
  /// result.when(
  ///   onSuccess: (items) => processItems(items),
  ///   onFailure: (error) => showSelectionError(error),
  /// );
  /// ```
  Resolver<List<T>, String> validateNotEmpty([String? errorMessage]) {
    return isNotEmpty ? Resolver.success(this) : Resolver.failure(errorMessage ?? 'List cannot be empty');
  }

  /// **Validates that list has minimum length**
  ///
  /// Returns a success result if the list has at least [minLength] items.
  /// Returns a failure result if the list is shorter than required.
  ///
  /// ## Parameters
  /// - [minLength]: Minimum required number of items
  /// - [errorMessage]: Optional custom error message
  ///
  /// ## Example
  /// ```dart
  /// final passwords = getPasswordOptions();
  /// final result = passwords.validateMinLength(3, 'Please provide at least 3 password options');
  ///
  /// result.when(
  ///   onSuccess: (options) => showPasswordOptions(options),
  ///   onFailure: (error) => showError(error),
  /// );
  /// ```
  Resolver<List<T>, String> validateMinLength(int minLength, [String? errorMessage]) {
    return length >= minLength ? Resolver.success(this) : Resolver.failure(errorMessage ?? 'List must have at least $minLength items');
  }
}
