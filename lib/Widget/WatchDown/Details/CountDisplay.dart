import 'package:flutter/material.dart';
import 'TimeContainer.dart';

class CountdownDisplay extends StatelessWidget {
  final Duration remainingTime;

  const CountdownDisplay({Key? key, required this.remainingTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int days = remainingTime.inDays;
    int hours = remainingTime.inHours.remainder(24);
    int minutes = remainingTime.inMinutes.remainder(60);
    int seconds = remainingTime.inSeconds.remainder(60);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TimeContainer(label: 'day', value: days),
        TimeContainer(label: 'hour', value: hours),
        TimeContainer(label: 'minutes', value: minutes),
        TimeContainer(label: 'second', value: seconds),
      ],
    );
  }
}
