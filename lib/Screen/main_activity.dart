import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/bottom_nav_provider.dart';
import 'ButtonNavPages/Image/image.dart';
import 'ButtonNavPages/Video/video.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({Key? key}) : super(key: key);

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  // String _fileText = "";
  final globalKey = GlobalKey<ScaffoldState>();
  List<Widget> pages = [
    const ImageHomePage(),
    const VideoHomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(builder: (context, nav, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Deleted Image & video Saver'),
        ),
        body: pages[nav.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              nav.changeIndex(value);
            },
            currentIndex: nav.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon:
                    Icon(Icons.image, color: Color.fromARGB(255, 71, 96, 236)),
                label: 'Image',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.video_library_sharp,
                    color: Color.fromARGB(255, 71, 96, 236)),
                label: 'Video',
              ),
            ]),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 211, 208, 221),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: 80,
                        width: 80,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Text(
                        "Welcome to Image & Video Saver",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w900),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  ListTile(
                    title: const Text("Home"),
                    leading: const Icon(Icons.home),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainActivity()));
                    },
                  ),
                  ListTile(
                    title: Text("Images"),
                    leading: Icon(Icons.image),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageHomePage()));
                    },
                  ),
                  ListTile(
                    title: Text("Videos"),
                    leading: Icon(Icons.video_call),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoHomePage()));
                    },
                  ),
                  ListTile(
                    title: const Text("Share App"),
                    leading: const Icon(Icons.share),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainActivity()));
                    },
                  ),
                  ListTile(
                    title: const Text("Rate us"),
                    leading: const Icon(Icons.rate_review),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainActivity()));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

// void _pickFile() async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles();

//   if (result != null && result.files.single.path != null) {
//     PlatformFile file = result.files.first;
//     log(file.name);

//     File _file = File(result.files.single.path!);
//     setState(() {
//       _fileText = _file.path;
//     });
//   } else {}
// }

// void _pickDirectory() async {
//   try {
//     String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

//     if (selectedDirectory == null) {
//       // User canceled the picker
//     }
//   } catch (error) {
//     log("Error $error");
//   }
// }
