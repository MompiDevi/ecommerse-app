import 'package:bloc/bloc.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'package:ecommerse_app/features/domain/usecase/get_all_products.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getAllProducts;
  static const int _pageSize = 10;
  int _currentPage = 0;
  List<Product> _allProducts = [];
  bool _hasMore = true;

  ProductBloc(this.getAllProducts) : super(ProductInitial()) {
    on<LoadProductsEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        _currentPage = 0;
        _allProducts = await getAllProducts();
        final initialProducts = _allProducts.take(_pageSize).toList();
        _hasMore = _allProducts.length > _pageSize;
        emit(ProductLoaded(initialProducts, hasMore: _hasMore));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    on<LoadMoreProductsEvent>((event, emit) async {
      if (!_hasMore || state is! ProductLoaded) return;
      final currentState = state as ProductLoaded;
      final nextPage = _currentPage + 1;
      final start = nextPage * _pageSize;
      final end = start + _pageSize;
      if (start >= _allProducts.length) {
        _hasMore = false;
        emit(ProductLoaded(currentState.products, hasMore: false));
        return;
      }
      final moreProducts = _allProducts.sublist(start, end > _allProducts.length ? _allProducts.length : end);
      final updatedProducts = List<Product>.from(currentState.products)..addAll(moreProducts);
      _currentPage = nextPage;
      _hasMore = updatedProducts.length < _allProducts.length;
      emit(ProductLoaded(updatedProducts, hasMore: _hasMore));
    });
  }
}
