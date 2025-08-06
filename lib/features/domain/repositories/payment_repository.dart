abstract class PaymentRepository {
  Future<String> confirmPayment({required double amount,
    required String currency,
    required String merchantDisplayName,});
}
