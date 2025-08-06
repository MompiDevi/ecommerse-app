import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerse_app/features/presentation/widgets/app_button.dart';

void main() {
  testWidgets('AppButton displays label and triggers onPressed', (WidgetTester tester) async {
    bool pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(
            label: 'Test Button',
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );
    expect(find.text('Test Button'), findsOneWidget);
    await tester.tap(find.byType(AppButton));
    expect(pressed, true);
  });
}
