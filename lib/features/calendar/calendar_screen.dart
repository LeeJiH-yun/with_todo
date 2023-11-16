import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  static String get routeName => 'CalendarScreen';
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0XFF44ADF4).withOpacity(0.72),
      child: Center(child: Text('메인달력화면')),
    );
  }
}
