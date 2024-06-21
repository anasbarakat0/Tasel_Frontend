// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class SearchResutl extends ShowProvidersState {
  final List<ProvidersModel> providers;
  SearchResutl({
    required this.providers,
  });
}

class FilterResutl extends ShowProvidersState {
  final List<ProvidersModel> providers;
  final int index;
  FilterResutl(this.index, {
    required this.providers,
  });
}
