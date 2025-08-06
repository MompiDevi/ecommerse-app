part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

class StartPayment extends PaymentEvent {
  final String clientSecret;
  final PaymentMethodParams paymentMethodParams;
  StartPayment({required this.clientSecret, required this.paymentMethodParams});
}
class PaymentSucceeded extends PaymentEvent {}
class PaymentFailed extends PaymentEvent {
  final String message;
  PaymentFailed(this.message);

  @override
  List<Object?> get props => [message];
}