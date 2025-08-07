// Abstract repository for payment operations, defining the contract for payment flows.
// Enables decoupling of data sources from business logic and supports mocking in tests.
abstract class PaymentRepository {
  Future<String> confirmPayment({required double amount,
    required String currency,
    required String merchantDisplayName,});
}
