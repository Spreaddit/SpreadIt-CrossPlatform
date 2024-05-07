import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';



// Function to pick video from the device's gallery using ImagePicker
Future<File?> pickVideoFromFilePicker() async {
  try {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) {
      return null;
    }
    print('video picked successfully');
    return File(video.path);
  } on PlatformException catch (e) {
    print('Failed to pick video $e');
    return null;
  }
}

// Function to pick video from the file system using HTML input element
Future<Uint8List?> pickVideoFromFilePickerWeb() async {
  if (kIsWeb) {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result != null) {
      return result.files.single.bytes;
    }
  }
  return null;
}