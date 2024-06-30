// file_handler_web.dart
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Future<MultipartFile> getMultipartFile(dynamic file) async {
  Uint8List fileBytes = await file.readAsBytes();
  return MultipartFile.fromBytes(
    fileBytes,
    filename: file.name,
  );
}
