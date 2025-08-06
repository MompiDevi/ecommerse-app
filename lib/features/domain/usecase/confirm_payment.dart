import 'package:flutter_stripe/flutter_stripe.dart';
import '../repositories/payment_repository.dart';

class ConfirmPayment {
  final PaymentRepository repository;
  ConfirmPayment(this.repository);

  Future<PaymentIntent?> call({required String clientSecret, required PaymentMethodParams paymentMethodParams}) {
    return repository.confirmPayment(clientSecret: clientSecret, paymentMethodParams: paymentMethodParams);
  }
}
