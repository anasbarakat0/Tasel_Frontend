// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
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
        emit(Error(message: data.message));
      } else if (data is ExceptionResult) {
        emit(Exception(message: data.message));
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
    Response response = await dio.post(
      '$baseurl/signup/store',
      data: provider.toMap(),
    );

    if (response.statusCode == 200) {
      print("1");
      return SignedUp(message: response.data['message']);
    } else {
      print("2");
      return ErrorResult(message: response.data['message']);
    }
  } on DioException catch (e) {
    print("3");
    return ExceptionResult(message: e.message.toString());
  }
}
