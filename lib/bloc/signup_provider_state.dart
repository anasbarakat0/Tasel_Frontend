part of 'signup_provider_bloc.dart';

@immutable
sealed class SignupProviderState {}

final class SignupProviderInitial extends SignupProviderState {}

class Success extends SignupProviderState {}

class Loading extends SignupProviderState {}

class Error extends SignupProviderState {
  final String message;
  Error({
    required this.message,
  });
}

class Exception extends SignupProviderState {
  final String message;
  Exception({
    required this.message,
  });
}
