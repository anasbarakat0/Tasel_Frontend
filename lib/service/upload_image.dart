import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

Future<String> uploadeImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  late File file;
  if (result != null) {
    file = File.fromRawPath(result.files.single.bytes!);

    var data = FormData.fromMap({'image': file});

    var dio = Dio();
    Response response = await dio.request(
      'https://tasel-backend-g6gsdfug6a-uc.a.run.app/upload',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return response.data['imageUrl'];
    } else {
      print('error upload image');
      return '';
    }
  } else {
    print('no image selected');
    return '';
  }
}
