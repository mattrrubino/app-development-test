import 'package:app_test/flutterfire.dart';
import 'package:app_test/screen/question_screen.dart';
import 'package:app_test/screen/video_screen.dart';
import 'package:app_test/screen/voice_screen.dart';
import 'package:app_test/util.dart';
import 'package:app_test/widget/menu_button.dart';
import 'package:app_test/widget/scaffold_wrapper.dart';
import "package:flutter/material.dart";

class HomeScreen extends StatelessWidget {
  final Function setAuth;

  HomeScreen(this.setAuth);

  void logout(BuildContext context) {
    print("Logged out");
    fireLogout();
    setAuth(false);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Text("Logout"),
                content: Text("Are you sure you want to log out?"),
                actions: [
                  TextButton(onPressed: () => logout(context), child: Text("Yes")),
                  TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("No")),
                ],
                backgroundColor: Colors.lightBlue.shade100,
              );
            });
          },
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MenuButton(
                text: "Play the video",
                clickFunc: () {
                  print("Play the video!");
                  pushScreen(context, VideoScreen());
                }),
            MenuButton(
                text: "Input the answer",
                clickFunc: () {
                  print("Input the answer!");
                  pushScreen(context, QuestionScreen());
                }),
            MenuButton(
                text: "Record your voice",
                clickFunc: () {
                  print("Record your voice!");
                  pushScreen(context, VoiceScreen());
                }),
          ],
        ));
  }
}
