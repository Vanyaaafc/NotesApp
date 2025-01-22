part of 'sign_up_bloc.dart';

base class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoadingState extends SignUpState {}

final class SignUpLoadedState extends SignUpState {}

final class SignUpErrorState extends SignUpState {
  final String error;

  SignUpErrorState({required this.error});
}
