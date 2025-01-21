import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/auth_screen/domain/auth_bloc.dart';
import 'package:notes_app/features/auth_screen/presentation/auth_screen.dart';
import 'package:notes_app/features/main_screen/presentation/main_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
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
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is ShowAuthScreenState) {
                  return const AuthScreen();
                }
                return TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(ShowAuthScreenEvent());
                  },
                  child: const Text('Sign In', style: TextStyle(fontSize: 16)),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SignUpErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }
              if (state is SignUpLoadedState) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const MainScreen();
                    }));
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return ContinueButton(
                  onPressed: state is SignUpLoadingState
                      ? null
                      : () {
                          context.read<AuthBloc>().add(RegisterEvent(
                                email: _createLoginController.text,
                                password: _createPasswordController.text,
                              ));
                        },
                  text: state is SignUpLoadingState ? null : 'Continue',
                  isLoading: state is SignUpLoadingState,
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
