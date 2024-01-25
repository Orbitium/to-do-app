import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_list_app/pages/calendar_page.dart';
import 'package:todo_list_app/widgets/background.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late Size screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: AppBackground(
        child: SizedBox(
          width: screenSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: screenSize.width * 0.05),
              const Text(
                "on.time",
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Make yourself \n more on time",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(
                    Size(screenSize.width * 0.6, 50),
                  ),
                ),
                onPressed: navigateToCalendarPage,
                child: const Text(
                  "Start",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: screenSize.width * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToCalendarPage() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft, child: const CalendarPage()));
  }
}
