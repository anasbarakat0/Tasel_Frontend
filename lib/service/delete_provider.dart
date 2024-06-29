import 'package:dio/dio.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/main.dart';

Future<bool> deleteProvider(TokenModel tokenId) async {
  try {
    Dio dio = Dio();
    Response response = await dio.delete('$baseurl/store/${tokenId.id}',
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
