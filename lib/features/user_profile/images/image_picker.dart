import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';



// Function to pick image from the device's gallery using ImagePicker
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

// Function to pick image from the file system using HTML input element
Future<Uint8List?> pickImageFromFilePickerWeb() async {
  if(kIsWeb)
 { 
  FilePickerResult? result = await FilePicker.platform.pickFiles();
if (result != null) {
  print(result.files.single.bytes);
  return result.files.single.bytes;
}
  }

}

ImageProvider<Object> selectImage(File? imageFile, String? imageURL, Uint8List? imageWeb) {
  if (imageWeb != null && kIsWeb) {
    return MemoryImage(imageWeb);
  } else if (imageFile != null) {
    return FileImage(imageFile);
  } else if (imageURL != null && imageURL.isNotEmpty) {
    return NetworkImage(imageURL);
  } else {
    return NetworkImage('https://addlogo.imageonline.co/image.jpg');
  }
}