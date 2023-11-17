import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:with_todo/features/calendar/check_list_item.dart';
import 'package:with_todo/features/calendar/model/check_list_model.dart';
import 'package:collection/collection.dart';

class CalendarScreen extends StatefulWidget {
  static String get routeName => 'CalendarScreen';
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  bool _trigger = false;
  DateTime _selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

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
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = DateTime(selectedDay.year, selectedDay.month,
                      selectedDay.day, 0, 0, 0);
                  focusedDay = focusedDay;
                });
              },
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
                    Container(
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
                            child: GestureDetector(
                              onTap: () {
                                _trigger = !_trigger;
                                setState(() {});
                              },
                              child: SizedBox(
                                width: 250,
                                child: Image.asset(_trigger
                                    ? 'assets/images/icon_bottom_arrow.png'
                                    : 'assets/images/icon_top_arrow.png'),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 7,
                                bottom: 5,
                                right: 10,
                              ),
                              child: SizedBox(
                                  width: 50,
                                  child: Image.asset(
                                      'assets/images/icon_edit.png')),
                            ),
                          )
                        ],
                      ),
                    ),
                    checkList(),
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

  Widget checkList() {
    //체크목록
    List<CheckListModel> checkItem = [
      CheckListModel(index: 0, checkable: false, content: '퇴근하기'),
      CheckListModel(index: 1, checkable: false, content: '퇴근하기1'),
      CheckListModel(index: 2, checkable: false, content: '퇴근하기2'),
      CheckListModel(index: 3, checkable: false, content: '퇴근하기3'),
      CheckListModel(index: 4, checkable: false, content: '퇴근하기4'),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_selectedDay.month}월 ${_selectedDay.day}일',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Container(
            height: 35,
            color: Colors.amber,
            child: SingleChildScrollView(
              child: Column(
                children: checkItem.mapIndexed((index, element) {
                  return CheckListItem(
                    index: index,
                    checkable: checkItem[index].checkable!,
                    content: checkItem[index].content!,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
