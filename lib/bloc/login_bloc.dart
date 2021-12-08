import 'package:bloc/bloc.dart';

import '../validators.dart';
import './login_event.dart';
import './login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginStarted>(_onStart);
    on<LoginChangedEmailTextField>(_onChangeEmailTextField);
    on<LoginChangedPasswordTextField>(_onChangePasswordTextField);
    on<LoginPressedLoginButton>(_onPressLoginButton);
  }

  late bool _isValidEmail;
  late bool _isValidPassword;
  late bool _isSubmitting;

  _onStart(LoginStarted event, Emitter<LoginState> emit) {
    _isValidEmail = true;
    _isValidPassword = true;
    _isSubmitting = false;
    emit(LoginLoadSuccess(
      isValidEmail: _isValidEmail,
      isValidPassword: _isValidPassword,
      isSubmitting: _isSubmitting,
    ));
  }

  _onChangeEmailTextField(
      LoginChangedEmailTextField event, Emitter<LoginState> emit) {
    _isValidEmail = Validators.isValidEmail(event.email);
    _isSubmitting = false;
    emit(LoginLoadSuccess(
      isValidEmail: _isValidEmail,
      isValidPassword: _isValidPassword,
      isSubmitting: _isSubmitting,
    ));
  }

  _onChangePasswordTextField(
      LoginChangedPasswordTextField event, Emitter<LoginState> emit) {
    _isValidPassword = Validators.isValidPassword(event.password);
    _isSubmitting = false;
    emit(LoginLoadSuccess(
      isValidEmail: _isValidEmail,
      isValidPassword: _isValidPassword,
      isSubmitting: _isSubmitting,
    ));
  }

  _onPressLoginButton(LoginPressedLoginButton event, Emitter<LoginState> emit) {
    _isSubmitting = true;
    emit(LoginLoadSuccess(
      isValidEmail: _isValidEmail,
      isValidPassword: _isValidPassword,
      isSubmitting: _isSubmitting,
    ));
    try {
      //! ...

      //! ...
      emit(LoginLoadSuccess(
        isValidEmail: _isValidEmail,
        isValidPassword: _isValidPassword,
        isSubmitting: _isSubmitting,
      ));
    } catch (e) {
      emit(LoginLoadFailure(errorMessage: e.toString()));
    }
  }
}
