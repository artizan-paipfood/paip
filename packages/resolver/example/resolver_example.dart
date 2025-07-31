import 'package:resolver/resolver.dart';

/// **Exemplo completo demonstrando as capacidades do package Resolver**
///
/// Este exemplo mostra:
/// - Uso básico do Resolver com tratamento de sucesso/falha
/// - Registro automático de eventos para analytics e logging
/// - Cenários do mundo real como chamadas de API e autenticação de usuário
/// - Tratamento e transformação de erros
/// - Streaming de eventos para monitoring e debugging
void main() async {
  print('🚀 Exemplo do Package Resolver\n');

  // =============================================================================
  // 1. BASIC RESOLVER USAGE
  // =============================================================================
  print('📋 1. Basic Resolver Usage');
  print('─' * 50);

  // Creating success and failure resolvers
  final successResult = Resolver.success('Operation completed successfully');
  final failureResult = Resolver.failure('Something went wrong');

  print('Success: ${successResult.isSuccess} - ${successResult.valueOrNull}');
  print('Failure: ${failureResult.isFailure} - ${failureResult.errorOrNull}');

  // Pattern matching with when
  final message = successResult.when(onSuccess: (value) => '✅ $value', onFailure: (error) => '❌ $error');
  print('Pattern matching result: $message\n');

  // =============================================================================
  // 2. ASYNC OPERATIONS WITH FUTURES
  // =============================================================================
  print('📡 2. Async Operations with Futures');
  print('─' * 50);

  // Simulating API calls
  print('Making API calls...');

  // Success case
  final userDataResult = await Result.fromFuture(_fetchUserData('user123'));

  userDataResult.whenVoid(onSuccess: (userData) => print('✅ User data loaded: $userData'), onFailure: (error) => print('❌ Failed to load user: $error'));

  // Error case with custom error message
  final invalidUserResult = await Result.fromFuture(_fetchUserData('invalid_user'), onError: (e) => 'User not found or service unavailable');

  invalidUserResult.whenVoid(onSuccess: (userData) => print('✅ User data: $userData'), onFailure: (error) => print('❌ Error: $error'));

  print('');

  // =============================================================================
  // 3. ADVANCED ERROR HANDLING
  // =============================================================================
  print('🔧 3. Advanced Error Handling');
  print('─' * 50);

  // Using fromFuture with custom error transformation
  final processedResult = await Result.fromFuture(_processPayment('card123', 99.99), onError: (e) => 'Payment processing failed: $e');

  processedResult.whenVoid(onSuccess: (result) => print('✅ Payment processed: ${result['transactionId']}'), onFailure: (error) => print('❌ Payment failed: $error'));

  print('');

  // =============================================================================
  // 4. EVENT SYSTEM FOR ANALYTICS AND LOGGING
  // =============================================================================
  print('📊 4. Event System for Analytics and Logging');
  print('─' * 50);

  // Configure automatic event registration
  ResolverEventController.events.configure(
    autoSuccess: true, // Automatically log successful operations
    autoError: true, // Automatically log failed operations
  );

  // Set up event listeners for analytics
  ResolverEventController.events.listen((subscriber) {
    subscriber.onSuccess((event) {
      print('📈 Analytics: ${event.message}');
      if (event.metadata != null) {
        print('   Metadata: ${event.metadata}');
      }
    });

    subscriber.onFailure((event) {
      print('🚨 Error Tracking: ${event.message}');
      if (event.metadata != null) {
        print('   Error Details: ${event.metadata}');
      }
    });

    subscriber.onHistory((event) {
      print('📝 User Action: ${event.message}');
    });
  });

  // Manual event registration for user actions
  ResolverEventController.events.addHistory('User opened payment screen', metadata: {'screen': 'payment', 'timestamp': DateTime.now().toIso8601String()});

  // Now operations will automatically generate events
  print('\nPerforming operations with automatic event tracking...');

  await Result.fromFuture(_authenticateUser('john@example.com', 'password123'));

  await Result.fromFuture(_loadUserProfile('john@example.com'), onError: (e) => 'Failed to load profile: $e');

  print('');

  // =============================================================================
  // 5. REAL-WORLD SCENARIO: E-COMMERCE CHECKOUT
  // =============================================================================
  print('🛒 5. Real-World Scenario: E-Commerce Checkout');
  print('─' * 50);

  await _performCheckoutFlow();

  print('');

  // =============================================================================
  // 6. RESULT TRANSFORMATION AND CHAINING
  // =============================================================================
  print('🔄 6. Result Transformation and Chaining');
  print('─' * 50);

  final numberResult = Resolver.success(42);

  // Transform success value
  final doubledResult = numberResult.map((value) => value * 2);
  print('Original: ${numberResult.value}, Doubled: ${doubledResult.value}');

  // Transform error
  final errorResult = Resolver.failure('Original error');
  final transformedError = errorResult.mapError((error) => 'Transformed: $error');
  print('Transformed error: ${transformedError.error}');

  // Flat mapping for chaining operations
  final chainedResult = numberResult.flatMap((value) {
    if (value > 40) {
      return Resolver.success('Value is high: $value');
    } else {
      return Resolver.failure('Value too low');
    }
  });
  print('Chained result: ${chainedResult.valueOrNull}');

  print('\n✨ Example completed! Check the analytics events above.');
}

// =============================================================================
// HELPER FUNCTIONS (Simulating real-world operations)
// =============================================================================

/// Simulates fetching user data from an API
Future<Map<String, dynamic>> _fetchUserData(String userId) async {
  await Future.delayed(Duration(milliseconds: 100)); // Simulate network delay

  if (userId == 'invalid_user') {
    throw Exception('User not found');
  }

  return {'id': userId, 'name': 'John Doe', 'email': 'john@example.com', 'verified': true};
}

/// Simulates payment processing
Future<Map<String, dynamic>> _processPayment(String cardId, double amount) async {
  await Future.delayed(Duration(milliseconds: 200));

  if (cardId == 'invalid_card') {
    throw Exception('Invalid card');
  }

  return {'transactionId': 'txn_${DateTime.now().millisecondsSinceEpoch}', 'amount': amount, 'status': 'completed'};
}

/// Simulates user authentication
Future<String> _authenticateUser(String email, String password) async {
  await Future.delayed(Duration(milliseconds: 150));

  if (email.isEmpty || password.isEmpty) {
    throw Exception('Invalid credentials');
  }

  return 'auth_token_${DateTime.now().millisecondsSinceEpoch}';
}

/// Simulates loading user profile
Future<UserProfile> _loadUserProfile(String email) async {
  await Future.delayed(Duration(milliseconds: 100));

  return UserProfile(name: 'John Doe', email: email, preferences: {'theme': 'dark', 'notifications': true});
}

/// Demonstrates a complete checkout flow with event tracking
Future<void> _performCheckoutFlow() async {
  print('Starting checkout flow...');

  // Step 1: Validate cart
  ResolverEventController.events.addHistory('User initiated checkout');

  final cartValidation = await Result.fromFuture(_validateCart(['item1', 'item2']));

  if (cartValidation.isFailure) {
    print('❌ Cart validation failed: ${cartValidation.error}');
    return;
  }

  // Step 2: Process payment
  ResolverEventController.events.addHistory('User confirmed payment');

  final paymentResult = await Result.fromFuture(_processPayment('card123', 149.99), onError: (e) => 'Payment failed: $e');

  if (paymentResult.isFailure) {
    print('❌ Payment failed: ${paymentResult.error}');
    return;
  }

  // Step 3: Create order
  final orderResult = await Result.fromFuture(_createOrder(paymentResult.value['transactionId']));

  orderResult.whenVoid(
    onSuccess: (orderId) {
      print('✅ Order created successfully: $orderId');
      ResolverEventController.events.addHistory('Order completed', metadata: {'orderId': orderId, 'amount': 149.99});
    },
    onFailure: (error) => print('❌ Order creation failed: $error'),
  );
}

/// Simulates cart validation
Future<bool> _validateCart(List<String> items) async {
  await Future.delayed(Duration(milliseconds: 50));
  return items.isNotEmpty;
}

/// Simulates order creation
Future<String> _createOrder(String transactionId) async {
  await Future.delayed(Duration(milliseconds: 100));
  return 'order_${DateTime.now().millisecondsSinceEpoch}';
}

// =============================================================================
// CUSTOM CLASSES
// =============================================================================

/// Custom error class for API operations
class ApiError {
  const ApiError(this.message);
  final String message;

  @override
  String toString() => 'ApiError: $message';
}

/// User profile data class
class UserProfile {
  const UserProfile({required this.name, required this.email, required this.preferences});

  final String name;
  final String email;
  final Map<String, dynamic> preferences;

  @override
  String toString() => 'UserProfile(name: $name, email: $email)';
}
