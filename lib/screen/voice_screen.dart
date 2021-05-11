import 'package:app_test/flutterfire.dart';
import 'package:app_test/screen/cloud_recordings_screen.dart';
import 'package:app_test/util.dart';
import 'package:app_test/widget/menu_button.dart';
import 'package:app_test/widget/notifications.dart';
import "package:flutter/material.dart";
import "package:app_test/widget/scaffold_wrapper.dart";
import 'package:path_provider/path_provider.dart';

import 'package:app_test/voice_recording.dart';

class VoiceScreen extends StatefulWidget {
  @override
  _VoiceScreenState createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  bool _completed = false;
  String filePath;

  void setCompleted(bool state) {
    setState(() {
      _completed = state;
    });
  }

  @override
  void initState() {
    initAsync();
    super.initState();
  }

  void initAsync() async {
    var dir = await getApplicationDocumentsDirectory();
    filePath = dir.path + "/audio.mp4";
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
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                ),
                Text(
                  "Read the sentence \n\"glad to meet you\".",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _completed
                    ? Column(
                        children: [
                          MenuButton(
                              text: "Play",
                              clickFunc: () async {
                                await playRecording(filePath);
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          MenuButton(
                              text: "Retry",
                              clickFunc: () async {
                                await deleteRecording(filePath);
                                setCompleted(false);
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          MenuButton(
                              text: "Submit",
                              clickFunc: () async {
                                bool success = await uploadAudio(filePath);

                                if (success) {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          SuccessNotification());
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          ErrorNotification());
                                }
                              }),
                        ],
                      )
                    : GestureDetector(
                        onLongPress: () async {
                          await initRecorder(filePath);
                          await startRecording();
                        },
                        onLongPressEnd: (details) async {
                          await stopRecording();
                          setCompleted(true);

                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Done"),
                                  content:
                                      Text("You have completed the recording!"),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text("Ok")),
                                  ],
                                  backgroundColor: Colors.lightBlue.shade100,
                                );
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Press and hold\nto record.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: MenuButton(
                  text: "Cloud Recordings",
                  clickFunc: () => pushScreen(
                    context,
                    CloudRecordingsScreen(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
