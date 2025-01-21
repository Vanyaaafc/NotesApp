part of 'auth_bloc.dart';

base class AuthEvent {}

final class AuthInitialEvent extends AuthEvent {}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

final class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  RegisterEvent({required this.email, required this.password});
}

final class ShowSignUpScreenEvent extends AuthEvent {}

final class ShowAuthScreenEvent extends AuthEvent {}

final class LogoutEvent extends AuthEvent {}


