import '../repositories/payment_repository.dart';

class ConfirmPayment {
  final PaymentRepository repository;
  ConfirmPayment(this.repository);

  Future<String> call({required double amount,
    required String currency,
    required String merchantDisplayName,}) async {
    return await repository.confirmPayment(
      amount: amount,
      currency: currency,
      merchantDisplayName: merchantDisplayName,
    );
    }
}
