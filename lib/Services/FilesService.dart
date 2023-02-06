import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FilesService{

  static Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  static Future<File> saveData(List lista) async {
    String data = json.encode(lista);

    final file = await getFile();
    return file.writeAsString(data);
  }

  static Future<String?> readData() async {
    try {
      final file = await getFile();

      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}