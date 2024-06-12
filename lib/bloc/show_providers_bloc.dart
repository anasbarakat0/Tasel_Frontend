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
    on<ShowProvidersEvent>((event, emit) async {
      var data = await getAllProviders();
      if (data is ListOf<ProvidersModel>) {
        emit(
          SuccessShowProviders(
            providers: data.resutl,
          ),
        );
      } else {
        emit(ErrorFetchingData());
      }
    });
  }
}

Future<ResultProviders> getAllProviders() async {
  try {
    Dio dio = Dio();
    Response response = await dio.get('$baseurl/stores');
    if (response.statusCode == 200) {
      List<ProvidersModel> providersModel = List.generate(
        response.data.length,
        (index) => ProvidersModel.fromMap(
          response.data[index],
        ),
      );
      return ListOf(
        resutl: providersModel,
      );
    } else {
      return ErrorModel(messge: 'No Internet Connection');
    }
  } on DioException catch (e) {
    return ExceptionModel(message: e.message.toString());
  }
}
