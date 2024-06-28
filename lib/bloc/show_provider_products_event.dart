// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'show_provider_products_bloc.dart';

@immutable
sealed class ShowProviderProductsEvent {}

class ShowProviderProducts extends ShowProviderProductsEvent {
  final String storeId;
  ShowProviderProducts({
    required this.storeId,
  });
}
