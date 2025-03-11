import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app/domain/usecases/auth_usecases.dart';
import 'package:notes_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:notes_app/presentation/auth/bloc/auth_event.dart';
import 'package:notes_app/presentation/auth/bloc/auth_state.dart';
import 'test_setup.dart';
import 'mocks.mocks.dart';

void main() {
  late AuthBloc authBloc;
  late MockSignUpUseCase mockSignUpUseCase;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() async {
    await setupTestDependencies();
    mockSignUpUseCase = getIt<SignUpUseCase>() as MockSignUpUseCase;
    mockLoginUseCase = getIt<LoginUseCase>() as MockLoginUseCase;
    authBloc = AuthBloc(mockSignUpUseCase, mockLoginUseCase);
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    // Test SignUp Event
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when SignUp succeeds',
      build: () {
        when(mockSignUpUseCase(any, any, any)).thenAnswer((_) async => null);
        return authBloc;
      },
      act: (bloc) => bloc.add(
          const SignUpEvent('test@example.com', 'password123', 'Test User')),
      expect: () => [
        AuthLoading(),
        AuthSuccess(),
      ],
      verify: (_) {
        verify(mockSignUpUseCase(
                'test@example.com', 'password123', 'Test User'))
            .called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when SignUp fails due to existing user',
      build: () {
        when(mockSignUpUseCase(any, any, any))
            .thenThrow(Exception('User already exists'));
        return authBloc;
      },
      act: (bloc) => bloc.add(
          const SignUpEvent('test@example.com', 'password123', 'Test User')),
      expect: () => [
        AuthLoading(),
        const AuthError('Exception: User already exists'),
      ],
      verify: (_) {
        verify(mockSignUpUseCase(
                'test@example.com', 'password123', 'Test User'))
            .called(1);
      },
    );

    // Test Login Event
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when Login succeeds',
      build: () {
        when(mockLoginUseCase(any, any)).thenAnswer((_) async => true);
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(const LoginEvent('test@example.com', 'password123')),
      expect: () => [
        AuthLoading(),
        AuthSuccess(),
      ],
      verify: (_) {
        verify(mockLoginUseCase('test@example.com', 'password123')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when Login fails with invalid credentials',
      build: () {
        when(mockLoginUseCase(any, any)).thenAnswer((_) async => false);
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(const LoginEvent('test@example.com', 'wrongpassword')),
      expect: () => [
        AuthLoading(),
        const AuthError('Invalid credentials'),
      ],
      verify: (_) {
        verify(mockLoginUseCase('test@example.com', 'wrongpassword')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when Login throws an exception',
      build: () {
        when(mockLoginUseCase(any, any)).thenThrow(Exception('Network error'));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(const LoginEvent('test@example.com', 'password123')),
      expect: () => [
        AuthLoading(),
        const AuthError('Exception: Network error'),
      ],
      verify: (_) {
        verify(mockLoginUseCase('test@example.com', 'password123')).called(1);
      },
    );
  });
}
