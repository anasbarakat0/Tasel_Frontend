import 'package:dio/dio.dart';
import 'package:tasel_frontend/Model/provider_info.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/main.dart';

Future<bool> updateProvider(TokenModel tokenId, ProviderInfo provider) async {
  try {
    Dio dio = Dio();
    Response response = await dio.put('$baseurl/users/${tokenId.id}',
        data: provider.toMap(),
        options:
            Options(headers: {"Authorization": "Bearer ${tokenId.token}"}));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } on DioException {
    return false;
  }
}
