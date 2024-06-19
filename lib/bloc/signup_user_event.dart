// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_user_bloc.dart';

@immutable
sealed class SignupUserEvent {}

class SignupUser extends SignupUserEvent {
  final UserModel user;

  SignupUser({
    required this.user,
  });
}
