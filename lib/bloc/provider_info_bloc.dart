// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:tasel_frontend/Model/provider_info.dart';
import 'package:tasel_frontend/Model/response_provider_info.dart';
import 'package:tasel_frontend/main.dart';

part 'provider_info_event.dart';
part 'provider_info_state.dart';

class ProviderInfoBloc extends Bloc<ProviderInfoEvent, ProviderInfoState> {
  ProviderInfoBloc() : super(ProviderInfoInitial()) {
    on<ShowProviderInfo>((event, emit) async {
      var data = await getProviderInfo(event.idProvider);
      if (data is SuccessModel) {
        emit(SuccessShowProviderInfo(provider: data.provider));
      } else if (data is ErrorModel) {
        emit(ErrorFetchingData(message: data.message));
      } else if (data is ExceptionModel) {
        emit(ErrorFetchingData(message: data.message));
      } else {
        emit(ErrorFetchingData(message: 'Error'));
      }
    });
  }
}

Future<ResultProviderInfo> getProviderInfo(String idProvider) async {
  try {
    Dio dio = Dio();
    Response response = await dio.get('$baseurl/store-info/$idProvider');
    if (response.statusCode == 200) {
      return SuccessModel(provider: ProviderInfo.fromMap(response.data));
    } else {
      return ErrorModel(message: 'there is an error');
    }
  } on DioException catch (e) {
    return ExceptionModel(message: e.message.toString());
  }
}
