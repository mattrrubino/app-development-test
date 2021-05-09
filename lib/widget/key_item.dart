import "package:flutter/material.dart";

class KeyItem extends StatelessWidget {
  final String _text;
  final Color _color;

  KeyItem(this._text, this._color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.stop,
          color: _color,
        ),
        Text(_text),
      ],
    );
  }
}
