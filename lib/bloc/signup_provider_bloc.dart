import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasel_frontend/Model/response_signup_model.dart';
import 'package:tasel_frontend/Model/signup_provider_model.dart';
import 'package:tasel_frontend/main.dart';
import 'package:tasel_frontend/service/upload_image.dart';

part 'signup_provider_event.dart';
part 'signup_provider_state.dart';

class SignupProviderBloc
    extends Bloc<SignupProviderEvent, SignupProviderState> {
  SignupProviderBloc() : super(SignupProviderInitial()) {
    on<SignedupProvider>((event, emit) async {
      var data = await signupProviderMethod(event.provider, event.image);
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
    SignupProviderModel provider, File image) async {
  try {
    print('Starting signupProviderMethod');
    print('Starting Upload the image');

    String imageUrl = await uploadImage(image);
    Map<String, dynamic> providerMap = provider.toMap();
    // providerMap.remove('image');
    providerMap['image'] = imageUrl;

    Dio dio = Dio();
    Response response =
        await dio.post('$baseurl/signup/Store', data: providerMap);

    if (response.statusCode == 200) {
      return SignedUp(message: response.data['message']);
    } else {
      return ErrorResult(message: response.data['message']);
    }
  } on DioException catch (e) {
    return ExceptionResult(message: e.message.toString());
  } catch (e) {
    return ExceptionResult(message: e.toString());
  }
}
