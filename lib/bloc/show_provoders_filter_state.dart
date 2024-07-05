// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'show_provoders_filter_bloc.dart';

@immutable
sealed class ShowProvodersFilterState {}

class ShowProvodersFilterInitial extends ShowProvodersFilterState {}

class ShowProvodersFilterLoading extends ShowProvodersFilterState {}

class ErrorShowProvidersFilter extends ShowProvodersFilterState {
  final String message;
  ErrorShowProvidersFilter({
    required this.message,
  });
}

final class ShowProvodersFilterSuccess extends ShowProvodersFilterState {
  final List<ProvidersModel> provider;
  ShowProvodersFilterSuccess({
    required this.provider,
  });
}
