part of 'login_provider_bloc.dart';

@immutable
sealed class LoginProviderEvent {}

class SignedinProvider extends LoginProviderEvent {
  final LoginModel user;
  SignedinProvider({
    required this.user,
  });
}
