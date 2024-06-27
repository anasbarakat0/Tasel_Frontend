class ProductsResult {}

class SuccessProducts extends ProductsResult {}

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
