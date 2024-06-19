// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignupResultModel {}

class SignedUp extends SignupResultModel {
  String message;
  SignedUp({
    required this.message,
  });
}

class ErrorResult extends SignupResultModel {
  String message;
  ErrorResult({
    required this.message,
  });
}

class ExceptionResult extends SignupResultModel {
  String message;
  ExceptionResult({
    required this.message,
  });
}
