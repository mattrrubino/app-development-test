import 'package:app_test/widget/video_app.dart';
import "package:flutter/material.dart";
import "package:app_test/widget/scaffold_wrapper.dart";

class VideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      content: Center(
        child: VideoApp(
          link:
              "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4",
          looping: true,
        ),
      ),
    );
  }
}
