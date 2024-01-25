// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_list_app/widgets/line_painter.dart';
import 'package:todo_list_app/widgets/scheduled_event.dart';

class DayEventTimeline extends StatefulWidget {
  const DayEventTimeline({super.key});

  @override
  State<DayEventTimeline> createState() => _DayEventTimelineState();
}

class _DayEventTimelineState extends State<DayEventTimeline> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xff3C1F7B),
                border: Border.all(
                  width: 3,
                  color: Color(0xff7E64FF),
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
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
            Padding(
              padding: EdgeInsets.only(left: 20, top: 40),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: CustomPaint(
                  size: Size(
                    1,
                    scheduledEventCardWidth - 30,
                  ),
                  painter: LinePainter(),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10),
            child: Column(
              children: [
                ScheduledEvent(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
