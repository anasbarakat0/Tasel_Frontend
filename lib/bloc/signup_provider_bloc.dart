import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart' as dio;
import 'package:meta/meta.dart';
import 'package:tasel_frontend/Model/response_signup_model.dart';
import 'package:tasel_frontend/Model/signup_provider_model.dart';
import 'package:tasel_frontend/main.dart';
import 'package:tasel_frontend/service/file_handler.dart';

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
    print('Starting signupProviderMethod');

    // Convert the provider to a map without the image
    Map<String, dynamic> providerMap = provider.toMap();
    providerMap.remove('image');

    dio.Dio dioClient = dio.Dio();

    // Handle the image separately
    dio.MultipartFile imageFile = await getMultipartFile(provider.image);

    // Create the FormData object
    dio.FormData formData = dio.FormData.fromMap({
      ...providerMap,
      'image': imageFile,
    });

    print('1');
    dio.Response response = await dioClient.post(
      '$baseurl/signup/store',
      data: formData,
    );
    print('2');

    if (response.statusCode == 200) {
      print('3');
      print(response.data);
      print('4');
      return SignedUp(message: response.data['message']);
    } else {
      print('5');
      print(response.data);
      return ErrorResult(message: response.data['message']);
    }
  } on dio.DioException catch (e) {
    print('7');
    print(e.message.toString());
    return ExceptionResult(message: e.message.toString());
  } catch (e) {
    print('Unexpected error: $e');
    return ExceptionResult(message: e.toString());
  }
}
