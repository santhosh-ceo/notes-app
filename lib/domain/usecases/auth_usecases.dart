import 'package:notes_app/domain/repositories/auth_repo.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<void> call(String email, String name, String password) =>
      repository.signUp(email, name, password);
}

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<bool> call(String email, String password) =>
      repository.login(email, password);
}
