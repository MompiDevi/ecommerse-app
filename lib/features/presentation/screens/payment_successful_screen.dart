import 'package:ecommerse_app/core/app_strings.dart';
import 'package:ecommerse_app/core/theme/app_colors.dart';
import 'package:ecommerse_app/features/presentation/widgets/app_button.dart';
import 'package:ecommerse_app/features/presentation/blocs/payment/payment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key, required this.amount, required this.currency, required this.merchantDisplayName});
  final double amount;
  final String currency;
  final String merchantDisplayName;
  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PaymentBloc>(context).add(StartPayment(widget.amount, widget.currency, widget.merchantDisplayName));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: BlocBuilder<PaymentBloc, PaymentState>(
              builder: (context, state) {
                if (state is PaymentLoading) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text(
                        AppStrings.processingPayment,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                } else if (state is PaymentSuccess) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                        size: 100,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        AppStrings.paymentSuccessful,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        AppStrings.paymentSuccessMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.grey,
                        ),
                      ),
                      const SizedBox(height: 40),
                      AppButton(
                        label: AppStrings.backToHome,
                        onPressed: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        borderRadius: 12,
                        height: 48,
                      )
                    ],
                  );
                } else if (state is PaymentFailure) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error,
                        color: AppColors.error,
                        size: 100,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        AppStrings.paymentFailed,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 40),
                      AppButton(
                        label: AppStrings.tryAgain,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        borderRadius: 12,
                        height: 48,
                      )
                    ],
                  );
                }
                // Default fallback
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
