// import 'package:dio/dio.dart';
// import 'package:tasel_frontend/Model/product_model.dart';
// import 'package:tasel_frontend/Model/response_login_model.dart';
// import 'package:tasel_frontend/main.dart';
// import 'package:http_parser/http_parser.dart';

// Future<bool> updateProduct(TokenModel tokenId, ProductModel product) async {
//   try {
//     Dio dio = Dio();
//     String filename = product.picture.path.split('/').last;
//     FormData formData = FormData.fromMap(
//       {
//         "name": product.name,
//         "price": product.price,
//         "description": product.description,
//         "picture": await MultipartFile.fromFile(
//           product.picture.path,
//           filename: filename,
//           contentType: MediaType('image', 'png'),
//         ),
//         'type': 'image/png'
//       },
//     );
//     Response response = await dio.put(
//       '$baseurl/products/${tokenId.id}',
//       data: formData,
//       options: Options(
//         headers: {
//           'accept': '*/*',
//           "Authorization": "Bearer ${tokenId.token}",
//           "content-type": "multipart/form-data"
//         },
//       ),
//     );
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   } on DioException catch (e) {
//     print('--------------------------hhhh---------------------------');
//     print(e.message.toString());
//     return false;
//   }
// }
