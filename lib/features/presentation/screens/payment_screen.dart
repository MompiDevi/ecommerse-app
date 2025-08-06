import 'package:ecommerse_app/features/presentation/blocs/payment/payment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentScreen extends StatefulWidget {
  final String clientSecret;
  final PaymentBloc paymentBloc;
  const PaymentScreen({super.key, required this.clientSecret, required this.paymentBloc});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _stripeSheetShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _showStripeSheetIfNeeded();
  }

  Future<void> _showStripeSheetIfNeeded() async {
    if (_stripeSheetShown) return;
    _stripeSheetShown = true;
    try {
        await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: widget.clientSecret,
        // Add your merchantDisplayName and other options as needed
        merchantDisplayName: 'Your Store Name',
      ),
    );
    await Stripe.instance.presentPaymentSheet();
      widget.paymentBloc.add(PaymentSucceeded());
    } catch (e) {
      widget.paymentBloc.add(PaymentFailed(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.paymentBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Loading background
            const Center(
              child: CircularProgressIndicator(),
            ),
            // Foreground: listen for payment state and show result if needed
            BlocBuilder<PaymentBloc, PaymentState>(
              builder: (context, state) {
                if (state is PaymentSuccess || state is PaymentFailure) {
                  // You can navigate to a result screen or show a dialog here
                  // For now, just show nothing (the result screen should be pushed by the bloc listener in your flow)
                  return const SizedBox.shrink();
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
