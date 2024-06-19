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
        emit(Error(message: 'try again later'));
      } else if (data is ExceptionResult) {
        emit(Exception(message: 'try again later'));
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
    print('the response is  ${response}');
    if (response.statusCode == 200) {
      print(
          "signup statuscode is 200 and the message is : ${response.data['message']}");
      return SignedUp(message: response.data['message']);
    } else {
      print('signup user error');
      return ErrorResult(message: response.data['message']);
    }
  } on DioException catch (e) {
    print('Signup user exception  ${e.message.toString()}');
    return ExceptionResult(message: e.message.toString());
  }
}
