import "package:flutter/material.dart";

void pushScreen(BuildContext context, Widget screen) {
  Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curve = Curves.ease;
        var tween = Tween(begin: Offset(1.0, 0.0), end: Offset.zero).chain(CurveTween(curve: curve));

        return SlideTransition(
            position: animation.drive(tween),
            child: child
        );
      }
  ));
}
