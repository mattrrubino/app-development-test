import "package:flutter/material.dart";

class SuccessNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Success"),
      content: Text("Submission received."),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("OK"))
      ],
      backgroundColor: Colors.lightBlue.shade100,
    );
  }
}

class ErrorNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Error"),
      content: Text("Something went wrong."),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("Ok")),
      ],
      backgroundColor: Colors.lightBlue.shade100,
    );
  }
}

