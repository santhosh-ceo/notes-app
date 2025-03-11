import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String name;
  final String password;

  const SignUpEvent(this.email, this.name, this.password);

  @override
  List<Object?> get props => [email, name, password];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}
