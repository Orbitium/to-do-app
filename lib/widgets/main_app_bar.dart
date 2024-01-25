import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "on.time",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.notifications,
              color: Colors.white,
              size: 26,
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.settings,
              color: Colors.white,
              size: 26,
            ),
          ],
        ),
      ],
    );
  }
}
