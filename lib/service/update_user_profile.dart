import 'package:dio/dio.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/Model/update_user_profile.dart';
import 'package:tasel_frontend/main.dart';

Future<bool> updateProfileUser(TokenModel tokenId, UpdateUserModel user) async {
  try {
    Dio dio = Dio();
    Response response = await dio.put('$baseurl/users/${tokenId.id}',
        data: user.toMap(),
        options: Options(headers: {
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTcyNjM2MTl9.0wZJ9GZoV2uhn3ql2PAF-G0WD6PGSzyVJx4ya_Eq7ZM"
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } on DioException {
    return false;
  }
}
