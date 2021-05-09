import "package:flutter/material.dart";

class MenuButton extends StatelessWidget {
  final double widthPercent;
  final double heightPercent;
  final Function clickFunc;
  final String text;

  MenuButton(
      {@required this.clickFunc,
      this.widthPercent = 75,
      this.heightPercent = 10,
      this.text = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * widthPercent / 100,
      height: MediaQuery.of(context).size.height * heightPercent / 100,
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.blue.shade900),
          backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: clickFunc,
      ),
    );
  }
}
