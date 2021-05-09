import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'dart:io';

FlutterAudioRecorder recorder;
AudioPlayer player = AudioPlayer();
bool _playing = false;

Future<void> initRecorder(String filePath) async {
  print("init recorder called");
  try {
    if (await FlutterAudioRecorder.hasPermissions) {
      await deleteRecording(filePath);

      recorder =
          FlutterAudioRecorder(filePath, audioFormat: AudioFormat.AAC);

      await recorder.initialized;
      print("Recorder initialized");
    } else {
      print("No permissions");
    }
  } catch (e) {
    print(e);
  }
}

Future<void> startRecording() async {
  try {
    await recorder.start();
  } catch (e) {
    print(e);
  }
}

Future<void> stopRecording() async {
  try {
    await recorder.stop();
  } catch (e) {
    print(e);
  }
}

Future<void> playRecording(String filePath) async {
  if (_playing) return;

  if (player == null)
    player = AudioPlayer();

  _playing = true;

  player.play(filePath, isLocal: true);
  player.onPlayerCompletion.listen((event) {
    _playing = false;
  });
}

Future<void> playCloud(String name, Function callback) async {
  if (_playing) return;

  _playing = true;
  String uid = FirebaseAuth.instance.currentUser.uid;
  String url = await FirebaseStorage.instance.ref("users/" + uid + "/audio/" + name).getDownloadURL();

  player.play(url, isLocal: false);
  player.onPlayerCompletion.listen((event) {
    _playing = false;
    callback();
  });
}

Future<void> deleteRecording(String filePath) async {
  File f = new File(filePath);

  if (await f.exists()) {
    print("Deleting...");
    await f.delete();
  }
}

Future<void> stopPlaying() async {
  try {
    if (player != null && _playing) {
      await player.stop();
      _playing = false;
    }
  }
  catch (e) {
    print(e);
  }
}