import 'package:app_test/flutterfire.dart';
import 'package:app_test/screen/email_screen.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:app_test/widget/scaffold_wrapper.dart";
import "package:app_test/widget/menu_button.dart";

import 'package:app_test/util.dart';

class LoginScreen extends StatelessWidget {
  final Function setAuth;

  LoginScreen(this.setAuth);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      leading: IconButton(
        icon: Icon(Icons.android),
        onPressed: null,
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MenuButton(
              text: "Login with Google",
              clickFunc: () async {
                bool success = await loginGoogle();
                if (success) {
                  setAuth(true);
                }
              }),
          MenuButton(
              text: "Login with Facebook",
              clickFunc: () async {
                bool success = await loginFacebook();
                if (success) {
                  setAuth(true);
                }
              }),
          MenuButton(
              text: "Login with Email",
              clickFunc: () {
                pushScreen(context, EmailScreen(setAuth));
              }),
        ],
      ),
    );
  }
}
