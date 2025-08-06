import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerse_app/features/presentation/blocs/cart/cart_bloc.dart';
import 'package:ecommerse_app/features/domain/usecase/add_to_cart.dart';
import 'package:ecommerse_app/features/domain/usecase/get_cart.dart';
import 'package:ecommerse_app/features/domain/usecase/remove_cart.dart';
import 'package:ecommerse_app/features/domain/usecase/update_cart.dart';
import 'package:ecommerse_app/features/domain/entities/cart.dart';
import 'package:ecommerse_app/features/domain/repositories/cart_repository.dart';
import 'package:mockito/annotations.dart';

class MockGetCart extends Mock implements GetCart {}
class MockRemoveCart extends Mock implements RemoveCart {}
class MockUpdateCart extends Mock implements UpdateCart {}

class MockAddToCart extends AddToCart {
  MockAddToCart() : super(repository: _FakeCartRepository());
  Future<void> Function({required Cart cart})? onCall;
  @override
  Future<void> call({required Cart cart}) async {
    if (onCall != null) {
      return onCall!(cart: cart);
    }
    return Future.value();
  }
}

class _FakeCartRepository implements CartRepository {
  @override
  Future<void> addToCart(Cart model) async => Future.value();
  @override
  Future<Cart> getCartById(int id) async => throw UnimplementedError();
  @override
  Future<Cart> removeItemFromCart(int productId) async => throw UnimplementedError();
  @override
  Future<void> updateCartItemQuantity(int productId, int quantity) async => Future.value();
}

@GenerateNiceMocks([MockSpec<Cart>()])
void main() {
  late CartBloc bloc;
  late MockGetCart mockGetCart;
  late MockAddToCart mockAddToCart;
  late MockRemoveCart mockRemoveCart;
  late MockUpdateCart mockUpdateCart;

  group('CartBloc', () {
    setUp(() {
      mockGetCart = MockGetCart();
      mockAddToCart = MockAddToCart();
      mockRemoveCart = MockRemoveCart();
      mockUpdateCart = MockUpdateCart();
      bloc = CartBloc(mockGetCart, mockAddToCart, mockRemoveCart, mockUpdateCart);
    });

    test('initial state is CartInitial', () {
      expect(bloc.state, isA<CartInitial>());
    });

    blocTest<CartBloc, CartState>(
      'emits [CartLoading, CartLoaded] when LoadCart is added and getCart succeeds',
      build: () {
        when(mockGetCart.call(userId: 1)).thenAnswer((_) async => Cart(
              id: 1,
              userId: 1,
              date: DateTime(2025, 8, 6),
              products: [],
            ));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadCart(userId: 1)),
      expect: () => [
        isA<CartLoading>(),
        isA<CartLoaded>().having((s) => s.cart?.userId, 'userId', 1),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [CartLoading, CartError] when LoadCart throws',
      build: () {
        when(mockGetCart.call(userId: 2)).thenThrow(Exception('error'));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadCart(userId: 2)),
      expect: () => [
        isA<CartLoading>(),
        isA<CartError>(),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [CartLoading, CartLoaded] when AddToCartEvent is added and succeeds',
      build: () {
        (bloc as dynamic).mockAddToCart.onCall = ({required cart}) async {};
        when(mockGetCart.call(userId: 1)).thenAnswer((_) async => Cart(
              id: 1,
              userId: 1,
              date: DateTime(2025, 8, 6),
              products: [],
            ));
        return bloc;
      },
      act: (bloc) => bloc.add(AddToCartEvent(cart: Cart(id: 1, userId: 1, date: DateTime(2025, 8, 6), products: []), userId: 1)),
      expect: () => [
        isA<CartLoading>(),
        isA<CartLoaded>(),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [CartLoading, CartError] when AddToCartEvent throws',
      build: () {
        (bloc as dynamic).mockAddToCart.onCall = ({required cart}) async { throw Exception('fail'); };
        return bloc;
      },
      act: (bloc) => bloc.add(AddToCartEvent(cart: Cart(id: 1, userId: 1, date: DateTime(2025, 8, 6), products: []), userId: 1)),
      expect: () => [
        isA<CartLoading>(),
        isA<CartError>(),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [CartLoading, CartLoaded] when RemoveFromCart is added and succeeds',
      build: () {
        when(mockRemoveCart.call(productId: 1)).thenAnswer((_) async => Cart(id: 1, userId: 1, date: DateTime(2025, 8, 6), products: []));
        return bloc;
      },
      act: (bloc) => bloc.add(RemoveFromCart(1)),
      expect: () => [
        isA<CartLoading>(),
        isA<CartLoaded>(),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [CartLoading, CartError] when RemoveFromCart throws',
      build: () {
        when(mockRemoveCart.call(productId: 2)).thenThrow(Exception('fail'));
        return bloc;
      },
      act: (bloc) => bloc.add(RemoveFromCart(2)),
      expect: () => [
        isA<CartLoading>(),
        isA<CartError>(),
      ],
    );
  });
}
