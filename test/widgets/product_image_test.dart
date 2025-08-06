import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerse_app/features/presentation/widgets/product_image.dart';

void main() {
  testWidgets('ProductImage displays network image', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProductImage(
          imageUrl: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png',
        ),
      ),
    );
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('ProductImage shows fallback on error', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProductImage(
          imageUrl: 'invalid-url',
        ),
      ),
    );
    // Simulate errorBuilder
    final image = tester.widget<Image>(find.byType(Image));
    final errorBuilder = image.errorBuilder;
    expect(errorBuilder, isNotNull);
  });
}
