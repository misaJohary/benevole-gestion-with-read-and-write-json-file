import 'dart:io';
import 'dart:convert';

import './provider/benevole.dart';

// import '../model/user.dart';

import 'package:path_provider/path_provider.dart';

class FileManager {
  static FileManager _instance;

  FileManager._internal() {
    _instance = this;
  }

  factory FileManager() => _instance ?? FileManager._internal();

  Future<String> get _directoryPath async {
    Directory directory = await getExternalStorageDirectory();
    return directory.path;
  }

  Future<File> get _jsonFile async {
    final path = await _directoryPath;
    return File('$path/mydata.json');
  }

  Future<Map<String, dynamic>> readJsonFile() async {
    String fileContent = 'Nothing to print';

    File file = await _jsonFile;

    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
        return json.decode(fileContent);
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

  Future<BenevoleFile> writeJsonFile(BenevoleFile newBenevole) async {
    // final Benevole benevole = Benevole('Julian', 36, ['Jewels', 'Juice', 'K']);
    File file = await _jsonFile;
    await file.writeAsString(json.encode(newBenevole));
    return newBenevole;
  }
}
