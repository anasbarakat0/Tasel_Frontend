import 'package:dio/dio.dart';
import 'package:tasel_frontend/Model/product_model.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/main.dart';

Future<bool> deleteProduct(ProductModel product, TokenModel tokenId) async {
  try {
    Dio dio = Dio();
    Response response = await dio.delete(
      '$baseurl/products/${product.id}',
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
