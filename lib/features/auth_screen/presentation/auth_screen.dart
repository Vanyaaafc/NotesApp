import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/main_screen/presentation/main_screen.dart';
import 'package:notes_app/features/sign_up/presentation/sign_up_screen.dart';
import 'package:notes_app/shared/styles/colors.dart';
import 'package:notes_app/shared/widgets/buttons/continue_button.dart';
import 'package:notes_app/shared/widgets/text/base_text.dart';
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
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleText(title: 'Let’s Login'),
                    const SizedBox(height: 12),
                    const BaseText(
                        title: 'And notes your idea', color: Colors.black45),
                    const SizedBox(height: 32),
                    const BaseText(title: 'Email Address'),
                    const SizedBox(height: 12),
                    MainTextField(
                      hint: 'Example: johndoe@gmail.com',
                      controller: _loginController,
                      isPassword: false,
                    ),
                    const SizedBox(height: 32),
                    const BaseText(title: 'Password'),
                    const SizedBox(height: 12),
                    MainTextField(
                      hint: '******',
                      controller: _passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: AppColors.darkPurple),
                        )),
                    const SizedBox(height: 32),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: ContinueButton(
                            onPressed: state is AuthLoadingState
                                ? null
                                : () {
                                    context.read<AuthBloc>().add(LoginEvent(
                                          email: _loginController.text,
                                          password: _passwordController.text,
                                        ));
                                  },
                            text: state is AuthLoadingState ? null : 'Login',
                            isLoading: state is AuthLoadingState,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don’t have any account?',
                              style: TextStyle(
                                  fontSize: 18, color: AppColors.darkPurple),
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<AuthBloc>()
                                    .add(ShowSignUpScreenEvent());
                              },
                              child: const Text(
                                'Register here',
                                style: TextStyle(
                                    fontSize: 18, color: AppColors.darkPurple),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
