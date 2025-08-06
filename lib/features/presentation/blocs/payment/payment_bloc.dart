import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../../domain/usecase/confirm_payment.dart';

part 'payment_events.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final ConfirmPayment confirmPaymentUseCase;
  PaymentBloc(this.confirmPaymentUseCase) : super(PaymentLoading()) {
    on<StartPayment>((event, emit) async {
      emit(PaymentLoading());
      try {
        String status = await confirmPaymentUseCase(
          amount: event.amount,
          currency: event.currency,
          merchantDisplayName: event.merchantDisplayName,
        );
        if(status == 'Success') {
          emit(PaymentSuccess());
        } else {
          emit(PaymentFailure('Payment failed'));
        }
      } catch (e) {
        emit(PaymentFailure(e.toString()));
      }
    });
    on<PaymentSucceeded>((event, emit) => emit(PaymentSuccess()));
    on<PaymentFailed>((event, emit) => emit(PaymentFailure(event.message)));
  }
}
