import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc/login_event.dart';
import './bloc/login_state.dart';
import './bloc/login_bloc.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 300.0,
          width: 500.0,
          child: Align(
            alignment: Alignment.center,
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isButtonEnabled(LoginLoadSuccess state) {
    return state.isValidForm &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        state.isSubmitting == false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<LoginBloc>().add(LoginStarted());
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginLoadSuccess) {
          return Form(
            child: Column(
              children: [
                TextFormField(
                  // validator: ,
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.email),
                    labelText: 'Email',
                    errorText: !state.isValidEmail ? 'invalid email' : null,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => context.read<LoginBloc>().add(
                      LoginChangedEmailTextField(email: _emailController.text)),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.lock),
                    labelText: 'Password',
                    errorText: !state.isValidPassword
                        ? 'Password should have more than 8 characters,\nincluding number, lower and upper character,\nand special symbol.'
                        : null,
                  ),
                  obscureText: false,
                  onChanged: (value) => context.read<LoginBloc>().add(
                      LoginChangedPasswordTextField(
                          password: _passwordController.text)),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    if (isButtonEnabled(state)) {
                      context.read<LoginBloc>().add(LoginPressedLoginButton(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ));
                    }
                  },
                ),
              ],
            ),
          );
        }
        return Form(
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  context.read<LoginBloc>().add(
                      LoginChangedEmailTextField(email: _emailController.text));
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: 'Password',
                ),
                obscureText: true,
                onChanged: (value) => context.read<LoginBloc>().add(
                    LoginChangedPasswordTextField(
                        password: _passwordController.text)),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                child: const Text('Login'),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
