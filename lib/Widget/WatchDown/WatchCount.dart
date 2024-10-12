import 'dart:async';
import 'package:flutter/material.dart';

import 'Details/CountDisplay.dart';

class CountdownTimerScreen extends StatefulWidget {
  final DateTime endTime;

  const CountdownTimerScreen({Key? key, required this.endTime}) : super(key: key);

  @override
  _CountdownTimerScreenState createState() => _CountdownTimerScreenState();
}

class _CountdownTimerScreenState extends State<CountdownTimerScreen> {
  late Timer _timer;
  late DateTime _endTime;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _endTime = widget.endTime;
    _timer = Timer.periodic( const Duration(seconds: 1), _updateTimer);
  }

  void _updateTimer(Timer timer) {
    final now = DateTime.now();
    if (now.isBefore(_endTime)) {
      setState(() {
        _remainingTime = _endTime.difference(now);
      });
    } else {
      _timer.cancel();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CountdownDisplay(remainingTime: _remainingTime);
  }
}


