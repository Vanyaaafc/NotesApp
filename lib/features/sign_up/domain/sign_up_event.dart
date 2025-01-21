part of 'sign_up_bloc.dart';

base class SignUpEvent {}

final class SignUpInitialEvent extends SignUpEvent {}

final class RegisterEvent extends SignUpEvent {
  final String email;
  final String password;

  RegisterEvent({required this.email, required this.password});
}
