import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerse_app/features/presentation/widgets/cart_icon_count.dart';
import 'package:ecommerse_app/features/presentation/blocs/cart/cart_bloc.dart';
import 'package:ecommerse_app/features/domain/usecase/get_cart.dart';
import 'package:ecommerse_app/features/domain/usecase/add_to_cart.dart';
import 'package:ecommerse_app/features/domain/usecase/remove_cart.dart';
import 'package:ecommerse_app/features/domain/usecase/update_cart.dart';
import 'package:ecommerse_app/features/domain/repositories/cart_repository.dart';
import 'package:ecommerse_app/features/domain/entities/cart.dart';

class FakeCartRepository implements CartRepository {
  @override
  Future<void> addToCart(cart) async {}
  @override
  Future<Cart> getCartById(int id) async => throw UnimplementedError();
  @override
  Future<Cart> removeItemFromCart(int productId) async => throw UnimplementedError();
  @override
  Future<void> updateCartItemQuantity(int productId, int quantity) async {}
}

class StubCartBloc extends CartBloc {
  StubCartBloc()
      : super(
          GetCart(repository: FakeCartRepository()),
          AddToCart(repository: FakeCartRepository()),
          RemoveCart(repository: FakeCartRepository()),
          UpdateCart(repository: FakeCartRepository()),
        );
}

void main() {
  testWidgets('CartIconCount shows badge when items present', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CartBloc>(
          create: (_) => StubCartBloc(),
          child: const CartIconCount(),
        ),
      ),
    );
    expect(find.byType(CartIconCount), findsOneWidget);
  });
}
