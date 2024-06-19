// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tasel_frontend/Model/Signup_user_model.dart';

class ResultUser {}

class SuccessModel extends ResultUser {}

class ErrorModel extends ResultUser {
  String messge;
  ErrorModel({
    required this.messge,
  });
}

class ExceptionModel extends ResultUser {
  String message;
  ExceptionModel({
    required this.message,
  });
}

class SuccessShowUserModel extends ResultUser {
  UserModel user;
  SuccessShowUserModel({
    required this.user,
  });
}
