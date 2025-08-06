import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerse_app/features/presentation/widgets/cart_summary_section.dart';

void main() {
  testWidgets('CartSummarySection displays subtotal, delivery fee, and total', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CartSummarySection(
          subtotal: 100,
          deliveryFee: 10,
          total: 110,
          onCheckout: () {},
        ),
      ),
    );
    expect(find.text('₹100.00'), findsOneWidget);
    expect(find.text('₹10.00'), findsOneWidget);
    expect(find.text('₹110.00'), findsOneWidget);
  });
}
