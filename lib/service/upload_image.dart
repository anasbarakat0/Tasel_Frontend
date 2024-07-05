import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:tasel_frontend/main.dart';
import 'package:tasel_frontend/service/file_handler.dart';

Future<String> uploadImage(File image) async {
  try {
    dio.Dio dioClient = dio.Dio();
    dio.MultipartFile imageFile = await getMultipartFile(image);
    dio.FormData formData = dio.FormData.fromMap({
      'image': imageFile,
    });
    dio.Response response =
        await dioClient.post('$baseurl/upload', data: formData);

    if (response.statusCode == 200) {
      return response.data['imageUrl'];
    } else {
      return 'Error';
    }
  } on dio.DioException catch (e) {
    return e.message.toString();
  }
}
