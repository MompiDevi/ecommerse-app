import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerse_app/features/presentation/widgets/product_details_bottom.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';

void main() {
  group('ProductDetailsBottom Widget', () {
    final product = Product(
      id: 1,
      title: 'Test Product',
      price: 99.99,
      description: 'A test product',
      image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png',
      category: 'Test',
    );
    final colors = [Colors.red, Colors.green, Colors.blue, Colors.yellow];
    final sizes = ['S', 'M', 'L', 'XL'];

    testWidgets('renders product title, price, and description', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProductDetailsBottom(
            product: product,
            quantity: 1,
            selectedColor: 0,
            selectedSize: 0,
            colors: colors,
            sizes: sizes,
            onQuantityChanged: (_) {},
            onColorChanged: (_) {},
            onSizeChanged: (_) {},
          ),
        ),
      );
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.textContaining('99.99'), findsOneWidget);
      expect(find.text('A test product'), findsOneWidget);
    });

    testWidgets('calls onQuantityChanged when increment/decrement is tapped', (WidgetTester tester) async {
      int quantity = 1;
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return ProductDetailsBottom(
                product: product,
                quantity: quantity,
                selectedColor: 0,
                selectedSize: 0,
                colors: colors,
                sizes: sizes,
                onQuantityChanged: (val) => setState(() => quantity = val),
                onColorChanged: (_) {},
                onSizeChanged: (_) {},
              );
            },
          ),
        ),
      );
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(quantity, 2);
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(quantity, 1);
    });
  });
}
