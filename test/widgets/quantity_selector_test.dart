import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerse_app/features/presentation/widgets/quantity_selector.dart';
import 'package:ecommerse_app/core/theme/app_colors.dart';

void main() {
  group('QuantitySelector', () {
    testWidgets('renders with correct quantity', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: QuantitySelector(
              quantity: 5,
              onIncrement: () {},
              onDecrement: () {},
            ),
          ),
        ),
      );
      expect(find.text('05'), findsOneWidget);
    });

    testWidgets('calls onIncrement when + is tapped', (tester) async {
      var incremented = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: QuantitySelector(
              quantity: 1,
              onIncrement: () => incremented = true,
              onDecrement: () {},
            ),
          ),
        ),
      );
      await tester.tap(find.byIcon(Icons.add));
      expect(incremented, isTrue);
    });

    testWidgets('calls onDecrement when - is tapped', (tester) async {
      var decremented = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: QuantitySelector(
              quantity: 2,
              onIncrement: () {},
              onDecrement: () => decremented = true,
            ),
          ),
        ),
      );
      await tester.tap(find.byIcon(Icons.remove));
      expect(decremented, isTrue);
    });

    testWidgets('decrement button is disabled at min', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: QuantitySelector(
              quantity: 1,
              onIncrement: () {},
              onDecrement: () {},
              min: 1,
            ),
          ),
        ),
      );
      final removeButton = tester.widget<Icon>(find.byIcon(Icons.remove));
      expect(removeButton.color, equals(AppColors.grey)); // Should be disabled color
    });

    testWidgets('increment button is disabled at max', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: QuantitySelector(
              quantity: 99,
              onIncrement: () {},
              onDecrement: () {},
              max: 99,
            ),
          ),
        ),
      );
      final addButton = tester.widget<Icon>(find.byIcon(Icons.add));
      expect(addButton.color, equals(AppColors.grey)); // Should be disabled color
    });
  });
}
