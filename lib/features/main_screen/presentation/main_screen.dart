import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/auth_screen/domain/auth_bloc.dart';
import 'package:notes_app/features/auth_screen/presentation/auth_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLogoutState) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => const AuthScreen(),
              ),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('aloha'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutEvent());
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
