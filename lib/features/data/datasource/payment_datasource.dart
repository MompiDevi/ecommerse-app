import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/services.dart';

class StripePaymentDataSource {
  Future<PaymentIntent?> confirmPayment({
    required String clientSecret,
    required PaymentMethodParams paymentMethodParams,
  }) async {
    try {
      return await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
        data: paymentMethodParams,
      );
    } on PlatformException catch (e) {
      print('Stripe confirmPayment error: ${e.message}');
      return null;
    } catch (e) {
      print('Stripe confirmPayment error: $e');
      return null;
    }
  }
}
