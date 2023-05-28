import 'dart:io';
import 'dart:developer';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String? videoPath;
  const VideoView({Key? key, this.videoPath}) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  List<Widget> buttonsList = [
    const Icon(Icons.download),
    const Icon(Icons.share),
  ];

  ChewieController? _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.file(
        File(widget.videoPath!),
      ),
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      aspectRatio: 5 / 6,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(errorMessage),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController!.pause();
    _chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chewie(controller: _chewieController!),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(buttonsList.length, (index) {
            return FloatingActionButton(
              heroTag: "$index",
              onPressed: () {
                switch (index) {
                  case 0:
                    log("download video");
                    ImageGallerySaver.saveFile(widget.videoPath!).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("video saved in your Gallery")));
                    });
                    break;

                  case 1:
                    log("share");
                    FlutterNativeApi.shareImage(widget.videoPath!);
                }
              },
              child: buttonsList[index],
            );
          }),
        ),
      ),
    );
  }
}
