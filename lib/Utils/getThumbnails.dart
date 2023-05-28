import 'package:video_thumbnail/video_thumbnail.dart';

Future<String> getThumbnail(String path) async {
  String? thumb;
  thumb = (await VideoThumbnail.thumbnailFile(
    video: path,
    imageFormat: ImageFormat.JPEG,
    maxWidth: 128,
    quality: 25,
  ));
  return thumb!;

  // final String = await VideoThumbnail.thumbnailData(
  //   video: path,
  //   imageFormat: ImageFormat.JPEG,
  //   maxWidth:
  //       128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
  //   quality: 25,
  // );
  // return String;
}
