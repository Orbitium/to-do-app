import 'package:flutter/material.dart';

const double scheduledEventCardWidth = 145;

class ScheduledEvent extends StatelessWidget {
  const ScheduledEvent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle(color: Colors.white, fontSize: 18),
      child: Container(
        height: scheduledEventCardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // ! TODO: CHECK IF EVENT IS STILL ACTIVE
          // ! IF it's NOT, CHANGE COLOR
          color: const Color(0xff3C1F7B),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dinner with Anna",
                    style: TextStyle(fontSize: 20),
                  ),
                  Checkbox(
                    value: false,
                    onChanged: null,
                    side: BorderSide(
                      color: Color(0xffC68AFF),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Color(0xffC68AFF),
                height: 0,
                thickness: 1.5,
              ),
              const SizedBox(height: 10),
              createEventInfo("Time", "08:00 AM"),
              createEventInfo("Place", "Tax Office"),
              createEventInfo("Notes", "Nothing."),
            ],
          ),
        ),
      ),
    );
  }

  Row createEventInfo(String key, String value) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            key,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
