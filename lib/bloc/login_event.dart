import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginStarted extends LoginEvent {}

class LoginChangedEmailTextField extends LoginEvent {
  const LoginChangedEmailTextField({
    required this.email,
  });

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginChangedPasswordTextField extends LoginEvent {
  const LoginChangedPasswordTextField({
    required this.password,
  });

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginPressedLoginButton extends LoginEvent {
  const LoginPressedLoginButton({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
