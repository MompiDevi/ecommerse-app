import 'package:bloc/bloc.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'package:ecommerse_app/features/domain/usecase/get_all_products.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getAllProducts;
  ProductBloc(this.getAllProducts) : super(ProductInitial()) {
    on<LoadProductsEvent>((event, emit) async {
       emit(ProductLoading());
      try {
        final products = await getAllProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
