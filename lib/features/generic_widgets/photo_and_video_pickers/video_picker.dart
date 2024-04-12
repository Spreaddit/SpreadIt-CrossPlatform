import 'dart:io';
import 'package:file_picker/file_picker.dart';

class pickVideoFromFilePicker {
  static Future<File?> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      return File(result.files.single.path!);
    }

    return null;
  }
}