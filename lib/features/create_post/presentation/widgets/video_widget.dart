import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final File? video;
  final Uint8List? videoWeb;
  final VoidCallback onIconPress;

  const VideoWidget({
    required this.video,
    required this.videoWeb,
    required this.onIconPress,
  });

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  late Future<void> videoDisplayed;

  @override
  void initState() {
    super.initState();
    if (kIsWeb && widget.videoWeb != null) {
      _controller = VideoPlayerController.network(
        'data:video/mp4;base64,${base64Encode(widget.videoWeb!)}',
      );
      videoDisplayed = _controller.initialize();  
    }
    else if (!kIsWeb && widget.video != null) {
      _controller = VideoPlayerController.file(widget.video!);
      videoDisplayed = _controller.initialize();
    }
  }
  

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return FutureBuilder(
        future: videoDisplayed,
        builder :(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: widget.onIconPress,
                  ),
                ),
              ],
            );
          }
          else {
            return CircularProgressIndicator();
          }
        }, 
      );
    }
  }


