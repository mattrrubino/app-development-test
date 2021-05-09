import "package:flutter/material.dart";
import "package:video_player/video_player.dart";

class VideoApp extends StatefulWidget {
  final bool looping;
  final String link;

  VideoApp({@required this.link, this.looping = false});

  @override
  _VideoAppState createState() => _VideoAppState(link: link, looping: looping);
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;

  final bool looping;
  final String link;

  _VideoAppState({@required this.link, this.looping = false});

  void toggleState() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        link)
      ..setLooping(looping)
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller != null && _controller.value.isInitialized
        ? video()
        : CircularProgressIndicator();
  }

  Widget video() => AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: GestureDetector(
        onTap: toggleState,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VideoPlayer(_controller),
            _controller.value.isPlaying
                ? Container()
                : Container(
                    alignment: Alignment.center,
                    color: Colors.black26,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 64,
                    ),
                  ),
            VideoProgressIndicator(_controller, allowScrubbing: true),
          ],
        ),
      ));
}
