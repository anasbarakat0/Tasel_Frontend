// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_user_bloc.dart';

@immutable
sealed class SignupUserState {}

final class SignupUserInitial extends SignupUserState {}

class Success extends SignupUserState {}

class Loading extends SignupUserState {}

class Error extends SignupUserState {
  final String message;
  Error({
    required this.message,
  });
}

class Exception extends SignupUserState {
  final String message;
  Exception({
    required this.message,
  });
}
