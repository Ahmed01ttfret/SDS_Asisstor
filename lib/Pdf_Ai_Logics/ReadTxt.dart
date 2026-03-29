import 'package:flutter/services.dart';

Future<String> readTxtFile(String path) async {
  String content = await rootBundle.loadString(path);
  return content;
}
