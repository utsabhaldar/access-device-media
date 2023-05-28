import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Provider/getStatusProvider.dart';
import 'image_view.dart';

class ImageHomePage extends StatefulWidget {
  const ImageHomePage({Key? key}) : super(key: key);

  @override
  State<ImageHomePage> createState() => _ImageHomePageState();
}

class _ImageHomePageState extends State<ImageHomePage> {
  bool _isFetched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GetStatusProvider>(builder: (context, file, child) {
        if (_isFetched == false) {
          file.getStatus(".jpg");
          Future.delayed(const Duration(microseconds: 1), () {
            _isFetched = true;
          });
        }
        return file.isWhatsappAvailable == false
            ? const Center(
                child: Text(
                  "While we load your images and videos\n\nPlease wait...",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              )
            : file.getImages.isEmpty
                ? const Center(
                    child: Text("No images available"),
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
                      children: List.generate(file.getImages.length, (index) {
                        final data = file.getImages[index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (_) => ImageView(
                                          imagePath: data.path,
                                        )),
                              );
                            },
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(File(data.path))),
                                  borderRadius: BorderRadius.circular(11)),
                            ));
                      }),
                    ),
                  );
      }),
    );
  }
}
