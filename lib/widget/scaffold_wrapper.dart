import "package:flutter/material.dart";

class ScaffoldWrapper extends StatelessWidget {

  final Widget leading;
  final Widget content;

  ScaffoldWrapper({@required this.leading, @required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Hero(tag: "bar",
              child: AppBar(
                leading: leading, title: Text("App Test"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight),
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade100,
              ),
              child: content,
            )
          ],
        ),
    );
  }

}
