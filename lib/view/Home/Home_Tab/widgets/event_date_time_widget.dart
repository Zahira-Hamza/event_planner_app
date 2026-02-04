import 'package:flutter/material.dart';

class EventDateTimeWidget extends StatelessWidget {
  String calendar_clock_icon;
  String event_date_time_text;
  String chooseDate_time_text;
  VoidCallback onPressed;
  EventDateTimeWidget({
    super.key,
    required this.calendar_clock_icon,
    required this.event_date_time_text,
    required this.onPressed,
    required this.chooseDate_time_text,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Image.asset(
          calendar_clock_icon,
          color: Theme.of(context).canvasColor,
          scale: screenWidth * .01,
        ),
        SizedBox(width: screenWidth * .01),
        Text(
          event_date_time_text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            onPressed();
          },
          child: Text(chooseDate_time_text),
        ),
      ],
    );
  }
}
