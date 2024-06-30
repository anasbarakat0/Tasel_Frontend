// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasel_frontend/Model/login_model.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/main.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Signin>((event, emit) async {
      var data = await loginUser(event.user);
      if (data is TokenModel) {
        emit(SuccessLogin(tokenId: TokenModel(token: data.token, id: data.id)));
      } else if (data is ErrorResult) {
        emit(ErrorLogin(message: data.message));
      } else if (data is ExceptionResult) {
        emit(ExceptionLogin(message: data.message));
      } else {
        emit(LoadingLogin());
      }
    });
  }
}

Future<ResultModel> loginUser(LoginModel login) async {
  try {
    Dio dio = Dio();
    Response response = await dio.post("$baseurl/login", data: login.toMap());
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(tokenS, response.data['token']);
      prefs.setString(userIdS, response.data['id']);
      isAuth = true;
      return TokenModel(token: response.data['token'], id: response.data['id']);
    } else if (response.statusCode == 400) {
      return ErrorResult(message: response.data);
    } else {
      return ErrorResult(message: response.data);
    }
  } on DioException catch (e) {
    return ExceptionResult(message: e.message.toString());
  }
}
