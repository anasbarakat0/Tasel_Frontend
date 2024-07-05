import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tasel_frontend/Model/providers_model.dart';
import 'package:tasel_frontend/Model/response_providers_model.dart';
import 'package:tasel_frontend/main.dart';

part 'show_provoders_filter_event.dart';
part 'show_provoders_filter_state.dart';

class ShowProvodersFilterBloc
    extends Bloc<ShowProvodersFilterEvent, ShowProvodersFilterState> {
  ShowProvodersFilterBloc() : super(ShowProvodersFilterInitial()) {
    on<ShowFilterProvider>(
      (event, emit) async {
        print('----------------------------0');
        var data = await seeProviderFilter(event.category, event.areaName);
        if (data is ListOf) {
          print('----------------------------1');
          emit(
            ShowProvodersFilterSuccess(
              provider: data.resutl as List<ProvidersModel>,
            ),
          );
        } else if (data is ExceptionModel) {
          print('----------------------------2');
          emit(
            ErrorShowProvidersFilter(
              message: data.message,
            ),
          );
        } else if (data is ErrorModel) {
          print('----------------------------3');
          emit(
            ErrorShowProvidersFilter(
              message: data.messge,
            ),
          );
        } else {
          print('----------------------------4');
          emit(ShowProvodersFilterLoading());
        }
      },
    );
  }
}

Future<ResultProviders> seeProviderFilter(
    String category, String areaName) async {
  try {
    print('$baseurl/stores/filter/?category=$category&areaName=$areaName');
    Dio dio = Dio();
    Response response = await dio
        .get('$baseurl/stores/filter/?category=$category&areaName=$areaName');
    print(response);
    if (response.statusCode == 200) {
      print('----------------------------5');
      List<ProvidersModel> providersModel = List.generate(
        response.data.length,
        (index) => ProvidersModel.fromMap(
          response.data[index],
        ),
      );
      return ListOf(resutl: providersModel);
    } else {
      print('----------------------------6');
      return ErrorModel(messge: response.data);
    }
  } on DioException catch (e) {
    print('----------------------------7');
    return ExceptionModel(message: e.message.toString());
  }
}
