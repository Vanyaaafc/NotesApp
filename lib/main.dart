import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/auth_screen/domain/auth_bloc.dart';
import 'package:notes_app/features/auth_screen/presentation/auth_screen.dart';
import 'package:notes_app/features/sign_up/domain/sign_up_bloc.dart';

import 'di.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: g.get<AuthBloc>()..add(AuthInitialEvent())),
        BlocProvider.value(value: g.get<SignUpBloc>()..add(SignUpInitialEvent()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthScreen(),
      ),
    );
  }
}