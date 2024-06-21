// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class SuccessLogin extends LoginState {
  TokenModel tokenId;
  SuccessLogin({
    required this.tokenId,
  });
}

class LoadingLogin extends LoginState {}

class ErrorLogin extends LoginState {
  final String message;
  ErrorLogin({
    required this.message,
  });
}

class ExceptionLogin extends LoginState {
  final String message;
  ExceptionLogin({
    required this.message,
  });
}
