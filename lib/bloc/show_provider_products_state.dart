// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'show_provider_products_bloc.dart';

@immutable
sealed class ShowProviderProductsState {}

final class ShowProviderProductsInitial extends ShowProviderProductsState {}

class SuccessShowProducts extends ShowProviderProductsState {
  final List<ProductModel> products;
  SuccessShowProducts({
    required this.products,
  });
}

class ErrorFetchingProducts extends ShowProviderProductsState {
  final String message;
  ErrorFetchingProducts({
    required this.message,
  });
}

class LoadingFetchingProduct extends ShowProviderProductsState {}
