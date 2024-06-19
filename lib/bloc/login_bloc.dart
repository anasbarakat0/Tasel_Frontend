import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'package:tasel_frontend/Model/login_model.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/main.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Signin>((event, emit) async {
      print(event.user.toMap());
      var data = await login(event.user);
      if (data is TokenModel) {
        emit(SuccessLogin());
      } else if (data is ErrorResult) {
        emit(ErrorLogin(message: 'try again later'));
      } else if (data is ErrorResult) {
        emit(ExceptionLogin(message: 'try again later'));
      } else {
        emit(LoadingLogin());
      }
    });
  }
}

Future<ResultModel> login(LoginModel login) async {
  try {
    http.Response response = await http.post(
        Uri(host: baseurl, port: 4003, path: '/login'),
        body: login.toJson(),
        headers: {
          "content-type": "application/json",
          "Accept": "application/json"
        });
    if (response.statusCode == 200) {
      return TokenModel(token: jsonDecode(response.body)['token']);
    } else {
      return ErrorResult(message: response.headers.toString());
    }
  } on http.ClientException catch (e) {
    print("---------");
    print(e.message.toString());
    return ExceptionResult(message: e.message.toString());
  }
}
