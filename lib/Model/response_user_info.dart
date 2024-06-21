// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tasel_frontend/Model/user_info_model.dart';

class ResultUserInfo {}

class SuccessUserModel extends ResultUserInfo {
  final UserInfo userinfo;
  SuccessUserModel({
    required this.userinfo,
  });
}

class ErrorModel extends ResultUserInfo {
  String messge;
  ErrorModel({
    required this.messge,
  });
}

class ExceptionModel extends ResultUserInfo {
  String message;
  ExceptionModel({
    required this.message,
  });
}
