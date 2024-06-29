import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tasel_frontend/Model/signup_user_model.dart';
import 'package:tasel_frontend/Model/response_signup_model.dart';
import 'package:tasel_frontend/main.dart';

part 'signup_user_event.dart';
part 'signup_user_state.dart';

class SignupUserBloc extends Bloc<SignupUserEvent, SignupUserState> {
  SignupUserBloc() : super(SignupUserInitial()) {
    on<SignupUser>((event, emit) async {
      var data = await signupUserMethod(event.user);
      if (data is SignedUp) {
        emit(Success());
      } else if (data is ErrorResult) {
        emit(Error(message: data.message));
      } else if (data is ExceptionResult) {
        emit(Exception(message: data.message));
      } else {
        emit(Loading());
      }
    });
  }
}

Future<SignupResultModel> signupUserMethod(UserModel user) async {
  try {
    Dio dio = Dio();
    Response response = await dio.post('$baseurl/signup', data: user.toMap());
    if (response.statusCode == 200) {
      return SignedUp(message: response.data['message']);
    } else {
      return ErrorResult(message: response.data['message']);
    }
  } on DioException {
    return ExceptionResult(message: 'Error, try again later');
  }
}
