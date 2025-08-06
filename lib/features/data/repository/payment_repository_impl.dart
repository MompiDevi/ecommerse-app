import 'package:flutter_stripe/flutter_stripe.dart';
import '../../data/datasource/payment_datasource.dart';
import '../../domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final StripePaymentDataSource dataSource;
  PaymentRepositoryImpl(this.dataSource);
  @override
  Future<PaymentIntent?> confirmPayment({required String clientSecret, required PaymentMethodParams paymentMethodParams}) {
    return dataSource.confirmPayment(clientSecret: clientSecret, paymentMethodParams: paymentMethodParams);
  }
}
