import 'package:app_test/widget/menu_button.dart';
import "package:flutter/material.dart";
import "package:app_test/widget/scaffold_wrapper.dart";
import 'package:app_test/flutterfire.dart';

class EmailScreen extends StatefulWidget {
  final Function authFunc;

  EmailScreen(this.authFunc);

  @override
  _EmailScreenState createState() => _EmailScreenState(authFunc);
}

class _EmailScreenState extends State<EmailScreen> {
  final double _widthPercent = 50;
  final double _heightPercent = 8;

  final Function authFunc;

  _EmailScreenState(this.authFunc);

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  String _prompt = "Enter email credentials.";

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      content: Padding(
        padding: EdgeInsets.only(
          left: 50,
          right: 50,
          top: 20,
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                _prompt,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _emailController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "test@example.com",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MenuButton(
                text: "Log in",
                widthPercent: _widthPercent,
                heightPercent: _heightPercent,
                clickFunc: () async {
                  String newPrompt = await loginEmail(
                      _emailController.text, _passwordController.text);

                  if (newPrompt != null) {
                    setState(() {
                      _prompt = newPrompt;
                    });
                  }
                  else {
                    Navigator.of(context).pop();
                    authFunc(true);
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              MenuButton(
                  text: "Register",
                  widthPercent: _widthPercent,
                  heightPercent: _heightPercent,
                  clickFunc: () async {
                    String newPrompt = await registerEmail(
                        _emailController.text, _passwordController.text);

                    if (newPrompt != null) {
                      setState(() {
                        _prompt = newPrompt;
                      });
                    }
                    else {
                      Navigator.of(context).pop();
                      authFunc(true);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
