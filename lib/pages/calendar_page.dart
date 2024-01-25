import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_list_app/pages/create_schedule_page.dart';
import 'package:todo_list_app/widgets/background.dart';
import 'package:todo_list_app/widgets/calendar.dart';
import 'package:todo_list_app/widgets/day_event_timeline.dart';
import 'package:todo_list_app/widgets/main_app_bar.dart';
import 'package:todo_list_app/widgets/scheduled_event.dart';

enum ViewType { schedule, events, notes }

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late Size screenSize;
  ViewType selectedCategory = ViewType.schedule;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SizedBox(
            width: screenSize.width,
            child: ListView(
              children: [
                Column(
                  children: [
                    const MainAppBar(),
                    const SizedBox(height: 30),
                    buildViewTypes(),
                    const SizedBox(height: 30),
                    const Calendar(),
                    const SizedBox(height: 30),
                    buildScheduleText(),
                    const Padding(
                      padding: EdgeInsets.only(left: 0, top: 15),
                      child: Column(
                        children: [
                          DayEventTimeline(),
                          DayEventTimeline(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Padding test() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xff3C1F7B),
                    border: Border.all(
                      width: 3,
                      color: const Color(0xff7E64FF),
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Center(
                    child: Text(
                      "20",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: Column(
                    children: [
                      ScheduledEvent(),
                      ScheduledEvent(),
                      ScheduledEvent(),
                      ScheduledEvent(),
                      ScheduledEvent(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Align buildScheduleText() {
    return const Align(
      alignment: Alignment.topLeft,
      child: Text(
        "Schedule",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Container buildViewTypes() {
    return Container(
      padding: const EdgeInsets.all(5),
      color: const Color(0xff3C1F7B),
      child: SizedBox(
        width: screenSize.width * 9,
        height: 40,
        child: Row(
          children: [
            buildViewType(ViewType.schedule, "Schedule"),
            buildViewType(ViewType.events, "Events"),
            buildViewType(ViewType.notes, "Notes"),
          ],
        ),
      ),
    );
  }

  Widget buildViewType(ViewType viewType, String name) {
    return Expanded(
      child: GestureDetector(
        onTap: () => changeViewType(viewType),
        child: Container(
          decoration: BoxDecoration(
            color:
                selectedCategory == viewType ? const Color(0xff272430) : null,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void changeViewType(ViewType newViewType) {
    setState(() {
      selectedCategory = newViewType;
    });
  }

  Widget buildFloatingActionButton() {
    return ExpandableFab(
      distance: 70,
      type: ExpandableFabType.up,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        backgroundColor: const Color.fromARGB(255, 126, 100, 225),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      closeButtonBuilder: RotateFloatingActionButtonBuilder(
        backgroundColor: const Color.fromARGB(255, 126, 100, 225),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
      overlayStyle: ExpandableFabOverlayStyle(
        blur: 5,
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            createSubFloatingActionButton(Icons.event_available, "Daily Event",
                navigateToScheduleCreationPage),
            const SizedBox(height: 10),
            createSubFloatingActionButton(
                Icons.date_range, "Schedule", navigateToScheduleCreationPage),
            const SizedBox(height: 10),
            createSubFloatingActionButton(Icons.sticky_note_2, "Note", null),
          ],
        ),
      ],
    );

    /* FloatingActionButton(
      onPressed: null,
      backgroundColor: Color.fromARGB(255, 126, 100, 225),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    ); */
  }

  void navigateToScheduleCreationPage() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const CreateSchedulePage()));
  }

  Widget createSubFloatingActionButton(IconData iconData, String title, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 5),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 126, 100, 225),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  iconData,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
