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
        Uri.dataFromString(
          String.fromCharCodes(widget.videoWeb!),
          mimeType: 'video/mp4',
        ).toString()
      )..initialize().then((_) {
          setState(() {}); // Ensure the video player is initialized
        });
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
    if (kIsWeb && widget.videoWeb != null) {
      return Stack(
        children: [
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
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
    } else {
      return FutureBuilder(
        future: videoDisplayed,
        builder :(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 160,
                  width: double.infinity,
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
}

// decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     image: FileImage(widget.video!),
                  //     fit: BoxFit.cover,