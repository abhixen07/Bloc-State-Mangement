import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBlocs;

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loginBlocs = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider(
        create: (_) => _loginBlocs,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (current, previous) => current.email != previous.email,
                  builder: (context, state) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      focusNode: emailFocusNode,
                      decoration: const InputDecoration(hintText: 'Email', border: OutlineInputBorder()),
                      onChanged: (value) {
                        context.read<LoginBloc>().add(EmailChanged(email: value));
                      },
                      onFieldSubmitted: (value) {},
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (current, previous) => current.password != previous.password,
                  builder: (context, state) {
                    return TextFormField(
                      keyboardType: TextInputType.text,
                      focusNode: passwordFocusNode,
                      decoration: const InputDecoration(hintText: 'Password', border: OutlineInputBorder()),
                      onChanged: (value) {
                        context.read<LoginBloc>().add(PasswordChanged(password: value));
                      },
                      onFieldSubmitted: (value) {},
                    );
                  }),
              const SizedBox(
                height: 50,
              ),

              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {

                  if (state.loginStatus == LoginStatus.error) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(content: Text('Error')),
                      );
                  }

                  if (state.loginStatus == LoginStatus.loading) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(content: Text('Submitting')),
                      );
                  }

                  if (state.loginStatus == LoginStatus.success) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(content: Text('Login successful')),
                      );
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (current, previous) => false,
                  builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                            context.read<LoginBloc>().add(LoginApi());
                        },
                        child: state.loginStatus == LoginStatus.loading ? CircularProgressIndicator() : const Text('Login'));
                  }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}