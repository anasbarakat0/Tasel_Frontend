import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tasel_frontend/Model/provisers_model.dart';
import 'package:tasel_frontend/Model/response_providers_model.dart';
import 'package:tasel_frontend/main.dart';

part 'show_providers_event.dart';
part 'show_providers_state.dart';

class ShowProvidersBloc extends Bloc<ShowProvidersEvent, ShowProvidersState> {
  ShowProvidersBloc() : super(ShowProvidersInitial()) {
    List<ProvidersModel> things = [];
    on<ShowProvidersEvent>((event, emit) async {
      var data = await getAllProviders();
      if (data is ListOf<ProvidersModel>) {
        things = data.resutl;
        emit(
          SuccessShowProviders(
            providers: data.resutl,
          ),
        );
      } else {
        emit(ErrorFetchingData());
      }
    });

    List<ProvidersModel> result = [];

    on<SearchEvent>((event, emit) {
      emit(LoadingFetching());
      result = [];
      things.forEach((e) {
        if (e.name.contains(event.lexem)) {
          result.add(e);
        }
      });

      emit(SearchResutl(providers: result));
    });
  }
}

Future<ResultProviders> getAllProviders() async {
  try {
    Dio dio = Dio();
    Response response = await dio.get('$baseurl/stores');
    if (response.statusCode == 200) {
      print('sssssssssssssssssssssssssss');
      List<ProvidersModel> providersModel = List.generate(
        response.data['data'].length,
        (index) => ProvidersModel.fromMap(
          response.data['data'][index],
        ),
      );
      print('greaaattttttttttttttttttt');
      return ListOf(
        resutl: providersModel,
      );
    } else {
      print('تباااااااااااااااااااااااااا');
      return ErrorModel(messge: 'No Internet Connection');
    }
  } on DioException catch (e) {
    print('سحقاااااااااااااااااااااااااا');
    return ExceptionModel(message: e.message.toString());
  }
}
