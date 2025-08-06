part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

class StartPayment extends PaymentEvent {
  final double amount;
  final String currency;
  final String merchantDisplayName;
  StartPayment(this.amount, this.currency, this.merchantDisplayName,);
}
class PaymentSucceeded extends PaymentEvent {}
class PaymentFailed extends PaymentEvent {
  final String message;
  PaymentFailed(this.message);

  @override
  List<Object?> get props => [message];
}