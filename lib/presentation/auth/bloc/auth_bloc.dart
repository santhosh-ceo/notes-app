import 'package:bloc/bloc.dart';
import 'package:notes_app/domain/usecases/auth_usecases.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final LoginUseCase loginUseCase;

  AuthBloc(this.signUpUseCase, this.loginUseCase) : super(AuthInitial()) {
    on<SignUpEvent>(_onSignUp);
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await signUpUseCase(event.email, event.name, event.password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final success = await loginUseCase(event.email, event.password);
      emit(success ? AuthSuccess() : const AuthError('Invalid credentials'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
