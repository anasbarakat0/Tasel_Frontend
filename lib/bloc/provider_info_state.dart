part of 'provider_info_bloc.dart';

@immutable
sealed class ProviderInfoState {}

final class ProviderInfoInitial extends ProviderInfoState {}

class SuccessShowProviderInfo extends ProviderInfoState {
  final ProviderInfo provider;

  SuccessShowProviderInfo({
    required this.provider,
  });
}

class ErrorFetchingData extends ProviderInfoState {
  final String message;
  ErrorFetchingData({
    required this.message,
  });
}

class LoadingFetching extends ProviderInfoState {}
