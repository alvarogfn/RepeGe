
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<File> getImageFileFromAssets(String path) async {
  final ByteData byteData = await rootBundle.load(path);

  return File.fromRawPath(byteData.buffer.asUint8List());
}
