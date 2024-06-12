// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'show_user_bloc.dart';

@immutable
sealed class ShowUserEvent {}

class ShowUser extends ShowUserEvent {
  final TokenModel token;
  ShowUser({
    required this.token,
  });
}
