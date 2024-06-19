// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_provider_bloc.dart';

@immutable
sealed class SignupProviderEvent {}

class SignedupProvider extends SignupProviderEvent {
  final SignupProviderModel provider;
  SignedupProvider({
    required this.provider,
  });
}
