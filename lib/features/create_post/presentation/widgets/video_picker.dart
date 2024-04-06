import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


Future<File?> pickVideoFromFilePicker() async {
  try {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) {
      return null;
    }
    return File(video.path);
  } on PlatformException catch (e) {
    print('Failed to pick image $e');
    return null;
  }
}