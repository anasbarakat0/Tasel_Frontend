// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_info_bloc.dart';

@immutable
sealed class ProfileInfoState {}

final class ProfileInfoInitial extends ProfileInfoState {}

class SuccessProfileInfo extends ProfileInfoState {
  final UserInfo userInfo;
  SuccessProfileInfo({
    required this.userInfo,
  });
}

class LoadingProfileInfo extends ProfileInfoState {}

class ErrorProfileInfo extends ProfileInfoState {
  final String message;
  ErrorProfileInfo({
    required this.message,
  });
}
