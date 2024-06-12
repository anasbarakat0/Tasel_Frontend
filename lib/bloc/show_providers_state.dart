part of 'show_providers_bloc.dart';

@immutable
sealed class ShowProvidersState {}

final class ShowProvidersInitial extends ShowProvidersState {}

class SuccessShowProviders extends ShowProvidersState {
  final List<ProvidersModel> providers;

  SuccessShowProviders({required this.providers});
}

class ErrorFetchingData extends ShowProvidersState {}

class LoadingFetching extends ShowProvidersState {}
