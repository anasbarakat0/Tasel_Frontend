// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'show_provoders_filter_bloc.dart';

@immutable
sealed class ShowProvodersFilterEvent {}

class ShowFilterProvider extends ShowProvodersFilterEvent {
  final String category;
  final String areaName;
  ShowFilterProvider({
    required this.category,
    required this.areaName,
  });
}
