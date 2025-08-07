import 'package:ecommerse_app/core/constants.dart';
import 'package:ecommerse_app/core/theme/app_theme.dart';
import 'package:ecommerse_app/features/presentation/blocs/cart/cart_bloc.dart';
import 'package:ecommerse_app/features/presentation/blocs/payment/payment_bloc.dart';
import 'package:ecommerse_app/features/presentation/blocs/product/product_bloc.dart';
import 'package:ecommerse_app/features/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ecommerse_app/di/injector.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  Stripe.publishableKey = stripePublishableKey;
  sl<FirebaseApp>();
  await sl<Stripe>().applySettings();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // BLoCs are provided via DI for modularity and testability
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProductBloc>()..add(LoadProductsEvent()),
        ),
        BlocProvider(
          create: (context) => sl<CartBloc>()..add(LoadCart(userId: 1)),
        ),
        BlocProvider(
          create: (context) => sl<PaymentBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
      ),
    );
  }
}
