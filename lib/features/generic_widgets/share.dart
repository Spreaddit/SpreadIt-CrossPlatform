
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

void sharePressed(String message) {
  Share.share(message);
}
