<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

# 🔧 Resolver

[![pub package](https://img.shields.io/pub/v/resolver.svg)](https://pub.dev/packages/resolver)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

**A powerful and elegant Dart package for handling operations that can succeed or fail, with built-in analytics and event tracking.**

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Installation](#-installation)
- [Quick Start](#-quick-start)
- [Result vs Resolver](#-result-vs-resolver)
- [Creating Results](#-creating-results)
- [Handling Results](#-handling-results)
- [Transformations](#-transformations)
- [Examples](#-examples)
- [Utilities - From Methods](#-utilities---from-methods)
- [Analytics System](#-analytics-system)
- [Migration Guide](#-migration-guide)
- [API Reference](#-api-reference)

---

## 🎯 Overview

Resolver provides a clean, type-safe way to handle success and failure states in your Dart/Flutter applications. No more try-catch blocks!

**Key Benefits:**
- 🎯 Type-safe error handling
- 🔄 Functional programming patterns
- 📊 Built-in analytics system
- 🚀 Simple and intuitive API

---

## 🚀 Installation

Add resolver to your `pubspec.yaml`:

```yaml
dependencies:
  resolver: ^1.0.0
```

Then import:

```dart
import 'package:resolver/resolver.dart';
```

---

## ⚡ Quick Start

```dart
import 'package:resolver/resolver.dart';

void main() {
  // Create success and failure results
  final success = Result.success('Hello World');
  final failure = Result.failure(Exception('Something went wrong'));
  
  // Handle results
  success.when(
    onSuccess: (value) => print('Got: $value'),
    onFailure: (error) => print('Error: $error'),
  );
  
  // Transform data
  final transformed = success.map((data) => data.toUpperCase());
  print(transformed.value); // 'HELLO WORLD'
}
```

---

## 🔍 Result vs Resolver

### **Result<T>** - For simple cases

Perfect for everyday use with `Exception` as the error type:

```dart
// Simple success/failure
Result<String> loadData() {
  return Result.success('data');
}

Result<int> parseNumber(String input) {
  try {
    return Result.success(int.parse(input));
  } catch (e) {
    return Result.failure(Exception('Invalid number'));
  }
}
```

### **Resolver<T, E>** - For custom error types

When you need specific error types:

```dart
// Custom error
class ApiError {
  final String message;
  final int code;
  ApiError(this.message, this.code);
}

// Using custom error type
Resolver<User, ApiError> loadUser() {
  return Resolver.success(User('John'));
  // or
  return Resolver.failure(ApiError('User not found', 404));
}
```

---

## 🎨 Creating Results

### Simple Results (with Exception)

```dart
// Success
final success = Result.success('Hello');
final userResult = Result.success(User('John'));

// Failure  
final failure = Result.failure(Exception('Something went wrong'));
final validationError = Result.failure(Exception('Invalid email'));
```

### Custom Error Results

```dart
// Success (same syntax)
final success = Resolver.success('Hello');

// Failure with custom error type
final apiFailure = Resolver.failure(ApiError('Network error', 500));
final validationFailure = Resolver.failure(ValidationError('email', 'Required'));
```

---

## 🎭 Handling Results

### Pattern Matching with `when`

```dart
final result = Result.success('Hello');

// Returns a value
final message = result.when(
  onSuccess: (value) => 'Got: $value',
  onFailure: (error) => 'Error: $error',
);

// For side effects only
result.whenVoid(
  onSuccess: (value) => print('Success: $value'),
  onFailure: (error) => print('Error: $error'),
);
```

### Safe Access

```dart
final result = Result.success('data');

// Safe access (no exceptions)
final value = result.valueOrNull; // 'data' or null
final error = result.errorOrNull; // null or error

// With fallback
final safeValue = result.getOrElse(() => 'default');

// Check state
if (result.isSuccess) {
  print('Operation succeeded');
}
```

---

## 🔄 Transformations

### Map - Transform success value

```dart
final result = Result.success(42);
final doubled = result.map((value) => value * 2); // Success(84)
final text = result.map((value) => 'Number: $value'); // Success('Number: 42')
```

### Chain operations with FlatMap

```dart
final userIdResult = Result.success('123');

final userResult = userIdResult.flatMap((userId) {
  return loadUserFromDatabase(userId); // Returns Result<User>
});
```

### Filter values

```dart
final numberResult = Result.success(5);

final filtered = numberResult.filter(
  (value) => value > 10,
  () => Exception('Number must be greater than 10'),
);
// Result: Failure(Exception('Number must be greater than 10'))
```

### Combine results

```dart
final name = Result.success('John');
final age = Result.success(30);

final combined = name.zip(age); // Success(('John', 30))
```

---

## 💡 Examples

### User Authentication

```dart
class AuthService {
  Result<User> signIn(String email, String password) {
    // Validate input
    if (email.isEmpty) {
      return Result.failure(Exception('Email is required'));
    }
    if (password.length < 6) {
      return Result.failure(Exception('Password too short'));
    }
    
    // Return success
    return Result.success(User(email));
  }
}

// Usage
final authService = AuthService();
final result = authService.signIn('user@example.com', 'password123');

result.when(
  onSuccess: (user) => print('Welcome ${user.email}!'),
  onFailure: (error) => print('Login failed: $error'),
);
```

### Data Processing Chain

```dart
Result<String> processUserData(String input) {
  return Result.success(input)
    .map((data) => data.trim())
    .filter((data) => data.isNotEmpty, () => Exception('Data cannot be empty'))
    .map((data) => data.toUpperCase())
    .onSuccess((data) => print('Processed: $data'));
}

final result = processUserData('  hello world  ');
// Prints: "Processed: HELLO WORLD"
// Returns: Success('HELLO WORLD')
```

### E-commerce Checkout

```dart
class CheckoutService {
  Result<Order> processCheckout(Cart cart, PaymentInfo payment) {
    return validateCart(cart)
      .flatMap((_) => processPayment(payment))
      .flatMap((paymentResult) => createOrder(cart, paymentResult));
  }
  
  Result<bool> validateCart(Cart cart) {
    if (cart.isEmpty) {
      return Result.failure(Exception('Cart is empty'));
    }
    return Result.success(true);
  }
  
  Result<PaymentResult> processPayment(PaymentInfo payment) {
    // Payment processing logic
    return Result.success(PaymentResult('txn_123'));
  }
  
  Result<Order> createOrder(Cart cart, PaymentResult payment) {
    return Result.success(Order('order_456', cart.total));
  }
}
```

---

## 🛠️ Utilities - From Methods

These utilities help convert operations that can throw exceptions into Results:

### fromFutureSimple - For async operations

```dart
AsyncResult<String> loadData() async {
  return await Resolver.fromFutureSimple(
    httpClient.get('/data'),
    onError: (e) => 'Failed to load data',
  );
}

// Usage
final result = await loadData();
result.when(
  onSuccess: (data) => print('Data: $data'),
  onFailure: (error) => print('Error: $error'),
);
```

### fromOperationSimple - For sync operations

```dart
Result<int> parseNumber(String input) {
  return Resolver.fromOperationSimple(
    () => int.parse(input),
    onError: (e) => 'Invalid number format',
  );
}

// Usage
final result = parseNumber('42');
// Success(42)

final failResult = parseNumber('abc');
// Failure(Exception('Invalid number format'))
```

### Advanced: fromFuture with custom errors

```dart
class ApiError {
  final String message;
  final int statusCode;
  ApiError(this.message, this.statusCode);
}

AsyncResolver<User, ApiError> loadUser(String id) async {
  return await Resolver.fromFuture<User, ApiError>(
    httpClient.get('/users/$id').then((response) => User.fromJson(response.data)),
    (error, stackTrace) => ApiError('Network error: $error', 500),
  );
}
```

### When to use utilities

| Method | Operation Type | Error Type | Use Case |
|--------|---------------|------------|----------|
| `fromFutureSimple` | Async | `Exception` | Simple APIs |
| `fromFuture` | Async | Custom | Advanced APIs |
| `fromOperationSimple` | Sync | `Exception` | Parsing, validation |
| `fromOperation` | Sync | Custom | Complex validation |

---

## 📊 Analytics System

Resolver includes automatic event tracking for monitoring and debugging:

### Basic Setup

```dart
void setupAnalytics() {
  // Enable automatic events
  ResolverEventController.events.configure(
    autoSuccess: true,
    autoError: true,
  );

  // Listen to events
  ResolverEventController.events.listen((subscriber) {
    subscriber.onSuccess((event) {
      print('📈 Success: ${event.message}');
      Analytics.track('operation_success', event.metadata);
    });

    subscriber.onFailure((event) {
      print('🚨 Error: ${event.message}');
      CrashReporting.recordError(event.message, event.metadata);
    });
  });
}
```

### Manual Events

```dart
// Log user actions
ResolverEventController.events.addHistory(
  'User completed checkout',
  metadata: {'orderId': '123', 'amount': 99.99},
);
```

---

## 🔄 Migration Guide

### Before (with try-catch)

```dart
Future<User> getUserData(String id) async {
  try {
    final response = await httpClient.get('/users/$id');
    return User.fromJson(response.data);
  } catch (e) {
    throw Exception('Failed to load user: $e');
  }
}
```

### After (with Result)

```dart
AsyncResult<User> getUserData(String id) async {
  return await Resolver.fromFutureSimple(
    httpClient.get('/users/$id').then((response) => User.fromJson(response.data)),
    onError: (e) => 'Failed to load user',
  );
}

// Usage
final result = await getUserData('123');
result.when(
  onSuccess: (user) => print('User: ${user.name}'),
  onFailure: (error) => print('Error: $error'),
);
```

---

## 📚 API Reference

### Type Aliases

```dart
typedef Result<T> = Resolver<T, Exception>;
typedef AsyncResult<T> = Future<Result<T>>;
typedef AsyncResolver<T, E> = Future<Resolver<T, E>>;
```

### Core Methods

- `Result.success(value)` - Create success result
- `Result.failure(exception)` - Create failure result
- `when<R>()` - Pattern matching with return value
- `whenVoid()` - Pattern matching for side effects
- `map<R>()` - Transform success value
- `flatMap<R>()` - Chain operations
- `filter()` - Filter values
- `zip()` - Combine results
- `valueOrNull` - Safe value access
- `errorOrNull` - Safe error access
- `getOrElse()` - Value with fallback
- `isSuccess` / `isFailure` - State checks

---

## 🤝 Contributing

Contributions are welcome! Please read our [contributing guide](CONTRIBUTING.md) before submitting PRs.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- [Package on pub.dev](https://pub.dev/packages/resolver)
- [API Documentation](https://pub.dev/documentation/resolver/latest/)
- [GitHub Repository](https://github.com/your-org/resolver)

---

**Made with ❤️ for the Dart & Flutter community**
