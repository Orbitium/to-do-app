import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Add box decoration
      decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.5, 1],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Color.fromARGB(255, 42, 42, 46),
            Color.fromARGB(255, 43, 18, 90),
            Color.fromARGB(255, 0, 0, 0),
          ],
        ),
      ),
      child: child,
    );
  }
}
