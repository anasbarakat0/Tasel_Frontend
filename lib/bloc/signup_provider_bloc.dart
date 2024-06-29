import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tasel_frontend/Model/response_signup_model.dart';
import 'package:tasel_frontend/Model/signup_provider_model.dart';
import 'package:tasel_frontend/main.dart';

part 'signup_provider_event.dart';
part 'signup_provider_state.dart';

class SignupProviderBloc
    extends Bloc<SignupProviderEvent, SignupProviderState> {
  SignupProviderBloc() : super(SignupProviderInitial()) {
    on<SignedupProvider>((event, emit) async {
      var data = await signupProviderMethod(event.provider);
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

Future<SignupResultModel> signupProviderMethod(
    SignupProviderModel provider) async {
  try {
    Dio dio = Dio();
    Response response =
        await dio.post('$baseurl/signup/store', data: provider.toMap());
    if (response.statusCode == 200) {
      return SignedUp(message: response.data['message']);
    } else {
      return ErrorResult(message: response.data['message']);
    }
  } on DioException catch (e) {
    return ExceptionResult(message: e.message.toString());
  }
}
