import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/auth_screen/domain/auth_bloc.dart';
import 'package:notes_app/features/auth_screen/presentation/auth_screen.dart';
import 'package:notes_app/features/main_screen/presentation/main_screen.dart';
import 'package:notes_app/features/sign_up/domain/sign_up_bloc.dart';
import 'package:notes_app/shared/styles/gradient.dart';
import 'package:notes_app/shared/widgets/buttons/continue_button.dart';
import 'package:notes_app/shared/widgets/text/title_text.dart';
import 'package:notes_app/shared/widgets/text_fields/main_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _createLoginController = TextEditingController();
  final TextEditingController _createPasswordController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _createLoginController.dispose();
    _createPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _matchingPasswords() {
    return _createPasswordController.text == _confirmPasswordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoadedState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) {
              return const MainScreen();
            }),
          );
        }
        if (state is SignUpErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          if (state is ShowAuthScreenState) {
            _createLoginController.clear();
            _createPasswordController.clear();
            _confirmPasswordController.clear();
            return const AuthScreen();
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
                          const TitleText(title: 'Registration'),
                          const SizedBox(height: 32),
                          MainTextField(
                            hint: 'Login',
                            controller: _createLoginController,
                            isPassword: false,
                          ),
                          const SizedBox(height: 24),
                          MainTextField(
                            hint: 'Password',
                            controller: _createPasswordController,
                            isPassword: true,
                          ),
                          const SizedBox(height: 24),
                          MainTextField(
                            hint: 'Confirm Password',
                            controller: _confirmPasswordController,
                            isPassword: true,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Do you have an account?',
                                  style: TextStyle(fontSize: 16)),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(ShowAuthScreenEvent());
                                },
                                child: const Text('Sign In',
                                    style: TextStyle(fontSize: 16)),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: ContinueButton(
                              onPressed: state is SignUpLoadingState
                                  ? null
                                  : () {
                                      if (!_matchingPasswords()) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text('Passwords do not match'),
                                        ));
                                        return;
                                      }
                                      context.read<SignUpBloc>().add(
                                            RegisterEvent(
                                              email:
                                                  _createLoginController.text,
                                              password:
                                                  _createPasswordController
                                                      .text,
                                            ),
                                          );
                                    },
                              text: state is SignUpLoadingState
                                  ? null
                                  : 'Continue',
                              isLoading: state is SignUpLoadingState,
                            ),
                          )
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
    );
  }
}
