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
        final result = await confirmPaymentUseCase(
          clientSecret: event.clientSecret,
          paymentMethodParams: event.paymentMethodParams,
        );
        if (result != null && result.status == PaymentIntentsStatus.Succeeded) {
          emit(PaymentSuccess());
        } else {
          emit(PaymentFailure('Payment failed or cancelled.'));
        }
      } catch (e) {
        emit(PaymentFailure(e.toString()));
      }
    });
    on<PaymentSucceeded>((event, emit) => emit(PaymentSuccess()));
    on<PaymentFailed>((event, emit) => emit(PaymentFailure(event.message)));
  }
}
