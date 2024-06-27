// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductsResult {}

// class SuccessProducts extends ProductsResult {
//   final List<ProductModel> products;
//   SuccessProducts({
//     required this.products,
//   });
// }

class ListOf<T> extends ProductsResult {
  List<T> resutl;
  ListOf({
    required this.resutl,
  });
}

class ErrorProducts extends ProductsResult {
  String message;
  ErrorProducts({
    required this.message,
  });
}

class ExceptionProducts extends ProductsResult {
  String message;
  ExceptionProducts({
    required this.message,
  });
}
