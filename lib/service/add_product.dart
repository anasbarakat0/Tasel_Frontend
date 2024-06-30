import 'package:dio/dio.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/main.dart';

Future<bool> addProduct(
    TokenModel tokenId, String name, double price, String description) async {
  try {
    Dio dio = Dio();
    Response response = await dio.post(
      '$baseurl/store/${tokenId.id}/products',
      data: {
        'name': name,
        'price': price,
        'description': description,
        'storeId': tokenId.id
      },
      options: Options(
        headers: {"Authorization": "Bearer ${tokenId.token}"},
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } on DioException {
    return false;
  }
}
