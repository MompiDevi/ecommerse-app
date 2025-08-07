import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerse_app/features/presentation/blocs/payment/payment_bloc.dart';
import 'package:ecommerse_app/features/domain/usecase/confirm_payment.dart';
import 'package:ecommerse_app/features/domain/repositories/payment_repository.dart';
import 'package:mockito/annotations.dart';
import 'payment_bloc_test.mocks.dart';

/// Unit tests for PaymentBloc, verifying state transitions and event handling for payment flows.
/// Uses bloc_test and mocks to ensure business logic correctness in isolation.

@GenerateMocks([ConfirmPayment])
class FakePaymentRepository implements PaymentRepository {
  @override
  Future<String> confirmPayment({required double amount, required String currency, required String merchantDisplayName}) async => 'Success';
}

void main() {
  test('initial state is PaymentLoading', () {
    final mockConfirmPayment = MockConfirmPayment();
    final bloc = PaymentBloc(mockConfirmPayment);
    expect(bloc.state, isA<PaymentLoading>());
  });

  blocTest<PaymentBloc, PaymentState>(
    'emits [PaymentLoading, PaymentSuccess] when StartPayment is added and confirmPayment returns Success',
    build: () {
      final mockConfirmPayment = MockConfirmPayment();
      when(mockConfirmPayment(
        amount: 10.0,
        currency: 'USD',
        merchantDisplayName: 'Test',
      )).thenAnswer((_) async => 'Success');
      return PaymentBloc(mockConfirmPayment);
    },
    act: (bloc) => bloc.add(StartPayment(10.0, 'USD', 'Test')),
    expect: () => [
      isA<PaymentLoading>(),
      isA<PaymentSuccess>(),
    ],
  );

  blocTest<PaymentBloc, PaymentState>(
    'emits [PaymentLoading, PaymentFailure] when StartPayment is added and confirmPayment returns failure',
    build: () {
      final mockConfirmPayment = MockConfirmPayment();
      when(mockConfirmPayment(
        amount: 10.0,
        currency: 'USD',
        merchantDisplayName: 'Test',
      )).thenAnswer((_) async => 'fail');
      return PaymentBloc(mockConfirmPayment);
    },
    act: (bloc) => bloc.add(StartPayment(10.0, 'USD', 'Test')),
    expect: () => [
      isA<PaymentLoading>(),
      isA<PaymentFailure>(),
    ],
  );

  blocTest<PaymentBloc, PaymentState>(
    'emits [PaymentLoading, PaymentFailure] when StartPayment throws',
    build: () {
      final mockConfirmPayment = MockConfirmPayment();
      when(mockConfirmPayment(
        amount: 10.0,
        currency: 'USD',
        merchantDisplayName: 'Test',
      )).thenThrow(Exception('fail'));
      return PaymentBloc(mockConfirmPayment);
    },
    act: (bloc) => bloc.add(StartPayment(10.0, 'USD', 'Test')),
    expect: () => [
      isA<PaymentLoading>(),
      isA<PaymentFailure>(),
    ],
  );
}
