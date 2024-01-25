import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  _updateSelectedDay(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = selectedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      onDaySelected: _updateSelectedDay,
      weekendDays: const [7],
      focusedDay: _focusedDay,
      firstDay: DateTime.now().subtract(
        const Duration(days: 14),
      ),
      lastDay: DateTime.now().add(
        const Duration(days: 365),
      ),
      headerStyle: const HeaderStyle(
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: Colors.white,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: Colors.white,
        ),
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      //
      calendarStyle: const CalendarStyle(
          isTodayHighlighted: false,
          defaultTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          weekNumberTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          weekendTextStyle: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          outsideTextStyle: TextStyle(
            color: Color(0xff7E7E7E),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          disabledTextStyle: TextStyle(
            color: Color(0xff7E7E7E),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          selectedTextStyle: TextStyle(
            color: Colors.black,
          ),
          selectedDecoration: BoxDecoration(color: Colors.purple)),

      // Days of the week style
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        weekendStyle: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),

      //
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          // ! TO-DO: If there are any plans for the day
          // ! display a red dot below the day (or up idk)
          if (day.year == _focusedDay.year &&
              day.month == _focusedDay.month &&
              day.day == _focusedDay.day) {
            return Padding(
              padding: const EdgeInsets.all(2.5),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff7E64FF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            );
          }

          return null;

          /* 
          * White line below the day
          * so you can show there are some events planned for that day
          Center(
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Divider(
                          color: Colors.white,
                          thickness: 2.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          */
        },
      ),
    );
  }
}
