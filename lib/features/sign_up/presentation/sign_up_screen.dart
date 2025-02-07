import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/auth_screen/domain/auth_bloc.dart';
import 'package:notes_app/features/auth_screen/presentation/auth_screen.dart';
import 'package:notes_app/features/sign_up/domain/sign_up_bloc.dart';
import 'package:notes_app/routing/app_router.gr.dart';
import 'package:notes_app/shared/styles/colors.dart';
import 'package:notes_app/shared/widgets/buttons/continue_button.dart';
import 'package:notes_app/shared/widgets/text/base_text.dart';
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
          AutoRouter.of(context).replaceAll([const HomeRoute()]);
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
          return SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleText(title: 'Register'),
                    const SizedBox(height: 12),
                    const BaseText(
                        title: 'And start taking notes', color: Colors.black45),
                    const SizedBox(height: 32),
                    const BaseText(title: 'Email Address'),
                    const SizedBox(height: 12),
                    MainTextField(
                      hint: 'Example: johndoe@gmail.com',
                      controller: _createLoginController,
                      isPassword: false,
                    ),
                    const SizedBox(height: 32),
                    const BaseText(title: 'Password'),
                    const SizedBox(height: 12),
                    MainTextField(
                      hint: '******',
                      controller: _createPasswordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 32),
                    const BaseText(title: 'Retype Password'),
                    const SizedBox(height: 12),
                    MainTextField(
                      hint: '******',
                      controller: _confirmPasswordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 38),
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
                            : 'Register',
                        isLoading: state is SignUpLoadingState,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?',
                            style: TextStyle(fontSize: 18, color: AppColors.darkPurple)),
                        TextButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(ShowAuthScreenEvent());
                          },
                          child: const Text('Login here',
                              style: TextStyle(fontSize: 18, color: AppColors.darkPurple)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
