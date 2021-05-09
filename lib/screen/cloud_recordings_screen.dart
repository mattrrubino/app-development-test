import 'package:app_test/flutterfire.dart';
import 'package:app_test/voice_recording.dart';
import 'package:app_test/widget/scaffold_wrapper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";

class CloudRecordingsScreen extends StatefulWidget {
  @override
  _CloudRecordingsScreenState createState() => _CloudRecordingsScreenState();
}

class _CloudRecordingsScreenState extends State<CloudRecordingsScreen> {
  bool _recordingsFound = false;
  ListResult _recordings;
  bool _resultsEmpty = false;
  String _playing = "";

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    _recordings = await recordingList();
    setState(() {
      _recordingsFound = true;
      _resultsEmpty = _recordings.items.isEmpty;
    });
  }

  @override
  void dispose() {
    super.dispose();
    recorder = null;
    player = null;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      content: Center(
        child: _recordingsFound && !_resultsEmpty
            ? ListView(
                children: _recordings.items.map((Reference ref) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 25,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      leading: _playing == ref.name
                          ? IconButton(
                              icon: Icon(
                                Icons.stop,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                print("You stopped: " + ref.name);
                                stopPlaying();
                                setState(() {
                                  _playing = "";
                                });
                              })
                          : IconButton(
                              icon: Icon(
                                Icons.play_arrow,
                                color: Colors.green,
                              ),
                              onPressed: () async {
                                print("You clicked: " + ref.name);
                                await stopPlaying();
                                await playCloud(ref.name, () {
                                  if (this.mounted) {
                                    setState(() => _playing = "");
                                  }
                                });
                                setState(() {
                                  _playing = ref.name;
                                });
                              },
                            ),
                      title: Text(ref.name),
                    ),
                  ),
                );
              }).toList())
            : _resultsEmpty
                ? Text(
                    "No recordings found.",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  )
                : CircularProgressIndicator(),
      ),
    );
  }
}
