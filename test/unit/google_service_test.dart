import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerse_app/google_service.dart';

void main() {
  group('GoogleSignInService', () {
    test('signInWithGoogle returns null on error', () async {
      // This is a logic test for error handling
      final result = await GoogleSignInService.signInWithGoogle();
      expect(result, isNull);
    });
  });
}
