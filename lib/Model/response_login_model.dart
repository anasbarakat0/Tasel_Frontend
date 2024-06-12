// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResultModel {}

class TokenModel extends ResultModel {
  String token;
  TokenModel({
    required this.token,
  });
}

class ErrorResult extends ResultModel {
  String message;
  ErrorResult({
    required this.message,
  });
}

class ExceptionResult extends ResultModel {
  String message;
  ExceptionResult({
    required this.message,
  });
}
