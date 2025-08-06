import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerse_app/features/presentation/widgets/app_icon_button.dart';

void main() {
  testWidgets('AppIconButton triggers onPressed', (WidgetTester tester) async {
    bool pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppIconButton(
            icon: Icons.add,
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );
    await tester.tap(find.byIcon(Icons.add));
    expect(pressed, true);
  });
}
