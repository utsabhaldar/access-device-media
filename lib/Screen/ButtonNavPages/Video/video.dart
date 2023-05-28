import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:third_app/Utils/getThumbnails.dart';
import '../../../Provider/getStatusProvider.dart';
import 'video_view.dart';

class VideoHomePage extends StatefulWidget {
  const VideoHomePage({Key? key}) : super(key: key);

  @override
  State<VideoHomePage> createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {
  bool _isFetched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GetStatusProvider>(builder: (context, file, child) {
        if (_isFetched == false) {
          file.getStatus(".mp4");
          Future.delayed(const Duration(microseconds: 1), () {
            _isFetched = true;
          });
        }
        return file.isWhatsappAvailable == false
            ? const Center(
                child: Text("Whatsapp not available"),
              )
            : file.getVideos.isEmpty
                ? const Center(
                    child: Text("No videos available"),
                  )
                : Container(
                    padding: const EdgeInsets.all(25),
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: 120,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      children: List.generate(file.getVideos.length, (index) {
                        final data = file.getVideos[index];
                        return FutureBuilder<String>(
                            future: getThumbnail(data.path),
                            builder: (context, snapshot) {
                              return snapshot.hasData
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (_) => VideoView(
                                                    videoPath: data.path,
                                                  )),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 127, 115, 111),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(
                                                    File(snapshot.data!))),
                                            borderRadius:
                                                BorderRadius.circular(11)),
                                      ),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    );
                            });
                      }),
                    ),
                  );
      }),
    );
  }
}
