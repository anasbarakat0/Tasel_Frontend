// file_handler_mobile.dart
import 'dart:io';
import 'package:dio/dio.dart';

Future<MultipartFile> getMultipartFile(File file) async {
  return await MultipartFile.fromFile(
    file.path,
    filename: file.path.split('/').last,
  );
}
