part of 'login_provider_bloc.dart';

@immutable
sealed class LoginProviderState {}

final class LoginProviderInitial extends LoginProviderState {}

class SuccessLoginProvider extends LoginProviderState {}

class LoadingLoginProvider extends LoginProviderState {}

class ErrorLoginProvider extends LoginProviderState {
  final String message;
  ErrorLoginProvider({
    required this.message,
  });
}

class ExceptionLoginProvider extends LoginProviderState {
  final String message;
  ExceptionLoginProvider({
    required this.message,
  });
}
