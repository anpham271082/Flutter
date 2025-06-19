import 'dart:convert';
import 'dart:async' show Future;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
class AppFiles {
  static final AppFiles _singleton = AppFiles._internal();
  factory AppFiles() => _singleton;
  AppFiles._internal();
  static AppFiles get shared => _singleton;
  dynamic _languages;
  Future<dynamic> readFileJson(String filePath) async {
    Future<String> jsonString = rootBundle.loadString(filePath);
    dynamic jsonResponse = jsonDecode(await jsonString);
    return jsonResponse;
  }
  Future<dynamic> readFileLanguage() async {
    Future<String> jsonString = rootBundle.loadString("assets/languages/language_vn.json");
    _languages = jsonDecode(await jsonString);
    return _languages;
  }
  String language(String key, String text) {
    if (["", null, false, 0].contains(_languages[key])) {
      return text;
    } else {
      return _languages[key];
    }
  }

  Future<File?> singleFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        return File(result.files.single.path!);
      } 
    } catch (e) {
      return null;
    }
    return null;
  }
  Future<List<File>?> multiplefiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        return files;
      } 
    } catch (e) {
      return null;
    }
    return null;
  }
  Future<List<File>?> multiplefilesExtensionFilter() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc'],
      );
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        return files;
      } 
    } catch (e) {
      return null;
    }
    return null;
  }
}