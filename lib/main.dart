import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import "package:app_test/screen/home_screen.dart";
import "package:app_test/screen/login_screen.dart";
import "package:flutter/services.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _authenticated = false;

  void _setAuth(bool state) {
    setState(() {
      _authenticated = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue.shade900),
      home: _authenticated ? HomeScreen(_setAuth) : LoginScreen(_setAuth),
    );
  }
}
