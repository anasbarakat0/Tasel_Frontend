// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'show_providers_bloc.dart';

@immutable
sealed class ShowProvidersEvent {}

class ShowProviders extends ShowProvidersEvent {}

class SearchEvent extends ShowProvidersEvent {
  final String lexem;
  SearchEvent({
    required this.lexem,
  });
}

class FilterBy extends ShowProvidersEvent {
  final String category;
  final int index;
  FilterBy(this.index, {
    required this.category,
  });
}
