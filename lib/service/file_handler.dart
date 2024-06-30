import 'package:universal_io/io.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Future<MultipartFile> getMultipartFile(File file) async {
  if (kIsWeb) {
    final bytes = await file.readAsBytes();
    final filename = file.uri.pathSegments.last;
    return MultipartFile.fromBytes(
      bytes,
      filename: filename,
    );
  } else {
    return MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
    );
  }
}
