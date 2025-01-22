import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/main_screen/presentation/main_screen.dart';
import 'package:notes_app/features/sign_up/presentation/sign_up_screen.dart';
import 'package:notes_app/shared/styles/gradient.dart';
import 'package:notes_app/shared/widgets/buttons/continue_button.dart';
import 'package:notes_app/shared/widgets/text/title_text.dart';
import 'package:notes_app/shared/widgets/text_fields/main_text_field.dart';

import '../domain/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadedState) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) {
                return const MainScreen();
              }),
            );
          }
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is ShowSignUpScreenState) {
              _loginController.clear();
              _passwordController.clear();
              return const SignUpScreen();
            }
            return GradientBackground(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 54, horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const TitleText(title: 'Authorization'),
                            const SizedBox(height: 32),
                            MainTextField(
                              hint: 'Login',
                              controller: _loginController,
                              isPassword: false,
                            ),
                            const SizedBox(height: 24),
                            MainTextField(
                              hint: 'Password',
                              controller: _passwordController,
                              isPassword: true,
                            ),
                            const SizedBox(height: 8),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Do not have an account?',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<AuthBloc>()
                                            .add(ShowSignUpScreenEvent());
                                      },
                                      child: const Text(
                                        'Create account',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child: ContinueButton(
                                    onPressed: state is AuthLoadingState
                                        ? null
                                        : () {
                                            context
                                                .read<AuthBloc>()
                                                .add(LoginEvent(
                                                  email: _loginController.text,
                                                  password:
                                                      _passwordController.text,
                                                ));
                                          },
                                    text: state is AuthLoadingState
                                        ? null
                                        : 'Continue',
                                    isLoading: state is AuthLoadingState,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
