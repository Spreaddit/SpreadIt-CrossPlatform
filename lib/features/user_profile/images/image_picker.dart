import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


Future<File?> pickImageFromFilePicker() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    return File(image.path);
  } on PlatformException catch (e) {
    print('Failed to pick image $e');
    return null;
  }
}

