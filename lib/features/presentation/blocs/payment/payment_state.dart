part of 'payment_bloc.dart';
@immutable
sealed class PaymentState {}

class PaymentLoading extends PaymentState {}
class PaymentSuccess extends PaymentState {}
class PaymentFailure extends PaymentState {
  final String message;
  PaymentFailure(this.message);

  @override
  List<Object?> get props => [message];
}