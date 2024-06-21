// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_info_bloc.dart';

@immutable
sealed class ProfileInfoEvent {}

class ShowProfileInfo extends ProfileInfoEvent {
  final String userId;
  ShowProfileInfo({
    required this.userId,
  });
}
