import 'package:tasel_frontend/Model/provisers_model.dart';

class ResultProviders {}

class SuccessModel extends ResultProviders {}

class ErrorModel extends ResultProviders {
  String messge;
  ErrorModel({
    required this.messge,
  });
}

class ExceptionModel extends ResultProviders {
  String message;
  ExceptionModel({
    required this.message,
  });
}

class ListOf<T> extends ResultProviders {
  List<T> resutl;
  ListOf({
    required this.resutl,
  });
}
