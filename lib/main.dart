import 'package:ecommerse_app/features/data/datasource/cart_remote_datasource.dart';
import 'package:ecommerse_app/features/data/datasource/product_remote_datasource.dart';
import 'package:ecommerse_app/features/data/repository/cart_repository_impl.dart';
import 'package:ecommerse_app/features/data/repository/product_repository_impl.dart';
import 'package:ecommerse_app/features/domain/repositories/cart_repository.dart';
import 'package:ecommerse_app/features/domain/usecase/add_to_cart.dart';
import 'package:ecommerse_app/features/domain/usecase/get_all_products.dart';
import 'package:ecommerse_app/features/domain/usecase/get_cart.dart';
import 'package:ecommerse_app/features/domain/usecase/remove_cart.dart';
import 'package:ecommerse_app/features/domain/usecase/update_cart.dart';
import 'package:ecommerse_app/features/presentation/blocs/cart/cart_bloc.dart';
import 'package:ecommerse_app/features/presentation/blocs/product/product_bloc.dart';
import 'package:ecommerse_app/features/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Import the generated file
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late GetCart _getCart;
  late AddToCart _addToCart;
  late RemoveCart _removeCart;
  late UpdateCart _updateCart;
  late GetAllProducts _getAllProducts;
  @override
  void initState() {
    super.initState();
    _getCart = GetCart(
        repository: CartRepositoryImpl(datasource: CartRemoteDataSource()));
    _addToCart = AddToCart(
        repository: CartRepositoryImpl(datasource: CartRemoteDataSource()));
    _removeCart = RemoveCart(
        repository: CartRepositoryImpl(datasource: CartRemoteDataSource()));
    _updateCart = UpdateCart(
        repository: CartRepositoryImpl(datasource: CartRemoteDataSource()));
    _getAllProducts = GetAllProducts(ProductRepositoryImpl( ProductRemoteDataSource())); 
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) =>
            ProductBloc(_getAllProducts)..add(LoadProductsEvent()),
       ),
        BlocProvider(
          create: (context) =>
              CartBloc(_getCart, _addToCart, _removeCart, _updateCart)..add(LoadCart(userId: 1)),
        ),
       
      ],
      child: const MaterialApp(home: SplashScreen()),
    );
  }
}
