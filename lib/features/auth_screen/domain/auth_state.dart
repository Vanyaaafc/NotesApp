part of 'auth_bloc.dart';

base class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthLoadedState extends AuthState {}

final class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState({required this.error});
}

final class SignUpLoadingState extends AuthState {}

final class SignUpLoadedState extends AuthState {}

final class SignUpErrorState extends AuthState {
  final String error;

  SignUpErrorState({required this.error});
}

final class ShowSignUpScreenState extends AuthState {}

final class ShowAuthScreenState extends AuthState {}

final class AuthLogoutState extends AuthState {}
