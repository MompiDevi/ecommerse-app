import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerse_app/features/presentation/widgets/product_carousel.dart';
import 'package:ecommerse_app/features/domain/entities/product.dart';

void main() {
  testWidgets('ProductCarousel displays related products', (WidgetTester tester) async {
    final products = [
      Product(id: 1, title: 'A', price: 10, description: '', image: '', category: ''),
      Product(id: 2, title: 'B', price: 20, description: '', image: '', category: ''),
    ];
    await tester.pumpWidget(
      MaterialApp(
        home: ProductCarousel(
          products: products,
          onProductTap: (_) {},
        ),
      ),
    );
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
  });
}
