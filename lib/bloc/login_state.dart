import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadFailure extends LoginState {
  final String? errorMessage;

  const LoginLoadFailure({
    this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}

class LoginLoadSuccess extends LoginState {
  const LoginLoadSuccess({
    required this.isValidEmail,
    required this.isValidPassword,
    required this.isSubmitting,
  });

  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;

  bool get isValidForm => isValidEmail && isValidPassword;

  @override
  List<Object> get props => [
        isValidEmail,
        isValidPassword,
        isSubmitting,
      ];
}
