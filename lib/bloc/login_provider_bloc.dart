// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:tasel_frontend/Model/login_model.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/main.dart';

part 'login_provider_event.dart';
part 'login_provider_state.dart';

class LoginProviderBloc extends Bloc<LoginProviderEvent, LoginProviderState> {
  LoginProviderBloc() : super(LoginProviderInitial()) {
    on<SignedinProvider>((event, emit) async {
      var data = await loginProvider(event.user);
      if (data is TokenModel) {
        emit(SuccessLoginProvider(
            tokenId: TokenModel(token: data.token, id: data.id)));
      } else if (data is ErrorResult) {
        emit(ErrorLoginProvider(message: 'try again later'));
      } else if (data is ErrorResult) {
        emit(ExceptionLoginProvider(message: 'try again later'));
      } else {
        emit(LoadingLoginProvider());
      }
    });
  }
}

Future<ResultModel> loginProvider(LoginModel login) async {
  try {
    Dio dio = Dio();
    Response response =
        await dio.post("$baseurl/login/store", data: login.toMap());
    if (response.statusCode == 200) {
      return TokenModel(token: response.data['token'], id: response.data['id']);
    } else {
      return ErrorResult(message: 'try again later');
    }
  } on DioException catch (e) {
    return ExceptionResult(message: e.message.toString());
  }
}
