part of 'show_user_bloc.dart';

@immutable
sealed class ShowUserState {}

final class ShowUserInitial extends ShowUserState {}

class SuccessShowUser extends ShowUserState {
  final UserModel user;

  SuccessShowUser({required this.user});
}

class ErrorFetchingDataUser extends ShowUserState {}

class LoadingFetchingUser extends ShowUserState {}
