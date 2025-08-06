import 'package:get_it/get_it.dart';
import '../features/data/datasource/cart_remote_datasource.dart';
import '../features/data/datasource/payment_datasource.dart';
import '../features/data/datasource/product_remote_datasource.dart';
import '../features/data/repository/cart_repository_impl.dart';
import '../features/data/repository/payment_repository_impl.dart';
import '../features/data/repository/product_repository_impl.dart';
import '../features/domain/repositories/cart_repository.dart';
import '../features/domain/repositories/payment_repository.dart';
import '../features/domain/repositories/product_repository.dart';
import '../features/domain/usecase/add_to_cart.dart';
import '../features/domain/usecase/confirm_payment.dart';
import '../features/domain/usecase/get_all_products.dart';
import '../features/domain/usecase/get_cart.dart';
import '../features/domain/usecase/remove_cart.dart';
import '../features/domain/usecase/update_cart.dart';
import '../features/presentation/blocs/cart/cart_bloc.dart';
import '../features/presentation/blocs/payment/payment_bloc.dart';
import '../features/presentation/blocs/product/product_bloc.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSource());
  sl.registerLazySingleton<CartRemoteDataSource>(() => CartRemoteDataSource());
  sl.registerLazySingleton<StripePaymentDataSource>(() => StripePaymentDataSource());

  // Repositories
  sl.registerLazySingleton<ProductRepositoryImpl>(() => ProductRepositoryImpl(sl()));
  sl.registerLazySingleton<ProductRepository>(() => sl<ProductRepositoryImpl>());
  sl.registerLazySingleton<CartRepositoryImpl>(() => CartRepositoryImpl(datasource: sl()));
  sl.registerLazySingleton<CartRepository>(() => sl<CartRepositoryImpl>());
  sl.registerLazySingleton<PaymentRepositoryImpl>(() => PaymentRepositoryImpl(sl()));
  sl.registerLazySingleton<PaymentRepository>(() => sl<PaymentRepositoryImpl>());

  // Usecases
  sl.registerLazySingleton<GetAllProducts>(() => GetAllProducts(sl()));
  sl.registerLazySingleton<GetCart>(() => GetCart(repository: sl()));
  sl.registerLazySingleton<AddToCart>(() => AddToCart(repository: sl()));
  sl.registerLazySingleton<RemoveCart>(() => RemoveCart(repository: sl()));
  sl.registerLazySingleton<UpdateCart>(() => UpdateCart(repository: sl()));
  sl.registerLazySingleton<ConfirmPayment>(() => ConfirmPayment(sl()));

  // BLoCs (use factory for new instance per injection)
  sl.registerFactory(() => ProductBloc(sl()));
  sl.registerFactory(() => CartBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => PaymentBloc(sl()));
}
