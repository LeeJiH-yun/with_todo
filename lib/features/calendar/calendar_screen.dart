import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  static String get routeName => 'CalendarScreen';
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  bool _trigger = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.now().subtract(Duration(days: 365 * 10 + 2)),
              lastDay: DateTime.now().add(Duration(days: 365 * 10 + 2)),
              locale: 'ko_KR',
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        //달성율
                        height: 80,
                        child: achievementBar(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 13),
            child: AnimatedContainer(
              //체크목록
              height: _trigger ? 550 : 107,
              duration: Duration(seconds: 1),
              curve: Curves.easeInOutCubic,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Color(0XFF666666),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _trigger = !_trigger;
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(_trigger
                                  ? 'assets/images/icon_bottom_arrow.png'
                                  : 'assets/images/icon_top_arrow.png'),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 5,
                                  bottom: 5,
                                  right: 15,
                                ),
                                child:
                                    Image.asset('assets/images/icon_edit.png'),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Column achievementBar() {
    //달성율
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            '오늘의 달성율입니다!',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
        ),
        LinearPercentIndicator(
          lineHeight: 13,
          percent: 0.5,
          animation: true,
          backgroundColor: Colors.yellow,
          progressColor: Colors.blue,
          barRadius: Radius.circular(50),
        )
      ],
    );
  }
}
