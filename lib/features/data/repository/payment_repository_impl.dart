import 'package:flutter_stripe/flutter_stripe.dart';
import '../../data/datasource/payment_datasource.dart';
import '../../domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final StripePaymentDataSource dataSource;
  PaymentRepositoryImpl(this.dataSource);
  @override
  Future<String> confirmPayment({required double amount,
    required String currency,
    required String merchantDisplayName,}) async {
    return await dataSource.confirmPayment(amount: amount, currency: currency, merchantDisplayName: merchantDisplayName);
  }
}
