import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerse_app/features/presentation/widgets/cart_item_tile.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';
import 'package:ecommerse_app/features/presentation/blocs/cart/cart_bloc.dart';
import 'package:mockito/annotations.dart';

import 'cart_item_tile_test.mocks.dart';


@GenerateMocks([CartBloc])
void main() {
  final product = Product(
    id: 1,
    title: 'Test Product',
    description: 'desc',
    price: 10.0,
    image: '',
    category: 'cat',
  );

  group('CartItemTile', () {
    testWidgets('renders product info and quantity', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: BlocProvider<CartBloc>(
              create: (_) => MockCartBloc(),
              child: CartItemTile(product: product, quantity: 2),
            ),
          ),
        ),
      );
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('02'), findsOneWidget); // QuantitySelector
    });

    testWidgets('swipe to dismiss triggers RemoveFromCart', (tester) async {
      final mockBloc = MockCartBloc();
      when(mockBloc.stream).thenAnswer((_) => const Stream.empty());
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: BlocProvider<CartBloc>(
              create: (_) => mockBloc,
              child: CartItemTile(product: product, quantity: 1),
            ),
          ),
        ),
      );
      await tester.drag(find.byType(CartItemTile), const Offset(-500, 0));
      await tester.pumpAndSettle();
      // If a dialog appears, confirm the action
      if (find.text('Remove').evaluate().isNotEmpty) {
        await tester.tap(find.text('Remove'));
        await tester.pumpAndSettle();
      }
      verify(mockBloc.add(any)).called(1);
    });
  });
}
