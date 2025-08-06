import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerse_app/features/presentation/widgets/summary_row.dart';

void main() {
  testWidgets('SummaryRow displays label and value', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SummaryRow(label: 'Subtotal', value: '₹100'),
      ),
    );
    expect(find.text('Subtotal'), findsOneWidget);
    expect(find.text('₹100'), findsOneWidget);
  });
}
