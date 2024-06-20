// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tasel_frontend/Model/provider_info.dart';

class ResultProviderInfo {}

class SuccessModel extends ResultProviderInfo {
  final ProviderInfo provider;
  SuccessModel({
    required this.provider,
  });
}

class ErrorModel extends ResultProviderInfo {
  String messge;
  ErrorModel({
    required this.messge,
  });
}

class ExceptionModel extends ResultProviderInfo {
  String message;
  ExceptionModel({
    required this.message,
  });
}
