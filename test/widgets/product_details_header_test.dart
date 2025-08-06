import 'package:ecommerse_app/features/domain/usecase/add_to_cart.dart';
import 'package:ecommerse_app/features/domain/usecase/get_cart.dart';
import 'package:ecommerse_app/features/domain/usecase/remove_cart.dart';
import 'package:ecommerse_app/features/domain/usecase/update_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerse_app/features/presentation/widgets/product_details_header.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'package:ecommerse_app/features/presentation/blocs/cart/cart_bloc.dart';

class FakeCartBloc extends Cubit<CartState> implements CartBloc {
  FakeCartBloc() : super(CartInitial());

  @override
  void add(CartEvent event) {
    // TODO: implement add
  }

  @override
  // TODO: implement addToCart
  AddToCart get addToCart => throw UnimplementedError();

  @override
  // TODO: implement getCart
  GetCart get getCart => throw UnimplementedError();

  @override
  void on<E extends CartEvent>(EventHandler<E, CartState> handler, {EventTransformer<E>? transformer}) {
    // TODO: implement on
  }

  @override
  void onEvent(CartEvent event) {
    // TODO: implement onEvent
  }

  @override
  void onTransition(Transition<CartEvent, CartState> transition) {
    // TODO: implement onTransition
  }

  @override
  // TODO: implement removeCart
  RemoveCart get removeCart => throw UnimplementedError();

  @override
  // TODO: implement updateCart
  UpdateCart get updateCart => throw UnimplementedError();
  // Implement any methods if needed for your widget
}

void main() {
  group('ProductDetailsHeader Widget', () {
    final product = Product(
      id: 1,
      title: 'Test Product',
      price: 99.99,
      description: 'A test product',
      image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png',
      category: 'Test',
    );

    testWidgets('renders product image and details label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CartBloc>(
            create: (_) => FakeCartBloc(),
            child: Scaffold(
              body: SizedBox(
                width: 400,
                height: 600,
                child: ProductDetailsHeader(
                  product: product,
                  onBack: () {},
                  onCart: () {},
                ),
              ),
            ),
          ),
        ),
      );
      expect(find.text('Details'), findsOneWidget);
      expect(find.byType(Hero), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });
  });
}