import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerse_app/features/presentation/blocs/product/product_bloc.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'package:ecommerse_app/features/domain/usecase/get_all_products.dart';
import 'package:ecommerse_app/features/domain/repositories/product_repository.dart';
import 'package:mockito/annotations.dart';
import 'product_bloc_test.mocks.dart';

@GenerateMocks([GetAllProducts])
void main() {
  test('initial state is ProductInitial', () {
    final mockGetAllProducts = MockGetAllProducts();
    final bloc = ProductBloc(mockGetAllProducts);
    expect(bloc.state, isA<ProductInitial>());
  });

  blocTest<ProductBloc, ProductState>(
    'emits [ProductLoading, ProductLoaded] when LoadProductsEvent is added and getAllProducts succeeds',
    build: () {
      final mockGetAllProducts = MockGetAllProducts();
      when(mockGetAllProducts()).thenAnswer((_) async => [Product(id: 1, title: 'Test', price: 10, description: 'desc', category: 'cat', image: 'img')]);
      return ProductBloc(mockGetAllProducts);
    },
    act: (bloc) => bloc.add(LoadProductsEvent()),
    expect: () => [
      isA<ProductLoading>(),
      isA<ProductLoaded>(),
    ],
  );

  blocTest<ProductBloc, ProductState>(
    'emits [ProductLoading, ProductError] when LoadProductsEvent throws',
    build: () {
      final mockGetAllProducts = MockGetAllProducts();
      when(mockGetAllProducts()).thenThrow(Exception('fail'));
      return ProductBloc(mockGetAllProducts);
    },
    act: (bloc) => bloc.add(LoadProductsEvent()),
    expect: () => [
      isA<ProductLoading>(),
      isA<ProductError>(),
    ],
  );
}
