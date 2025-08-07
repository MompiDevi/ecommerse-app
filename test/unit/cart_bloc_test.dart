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
import 'cart_bloc_test.mocks.dart';

// Unit tests for CartBloc, verifying state transitions and event handling for cart operations.
// Uses bloc_test and mocks to ensure business logic correctness in isolation.
@GenerateMocks([GetCart, AddToCart, RemoveCart, UpdateCart])

void main() {
  late MockGetCart mockGetCart;
  late MockAddToCart mockAddToCart;
  late MockRemoveCart mockRemoveCart;
  late MockUpdateCart mockUpdateCart;
  late CartBloc bloc;

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
        when(mockAddToCart.call(cart: anyNamed('cart'))).thenAnswer((_) async => Future.value());
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
        when(mockAddToCart.call(cart: anyNamed('cart'))).thenThrow(Exception('fail'));
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

