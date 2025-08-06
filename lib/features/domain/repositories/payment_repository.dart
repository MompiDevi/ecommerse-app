import 'package:flutter_stripe/flutter_stripe.dart';

abstract class PaymentRepository {
  Future<PaymentIntent?> confirmPayment({required String clientSecret, required PaymentMethodParams paymentMethodParams});
}
