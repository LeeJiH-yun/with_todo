import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:with_todo/core/common/components/navigation_bar.dart';
import 'package:with_todo/features/calendar/check_list_item.dart';
import 'package:collection/collection.dart';
import 'package:with_todo/features/todo/model/check_list_model.dart';
import 'package:with_todo/core/database_config.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  static String get routeName => 'CalendarScreen';
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  bool _trigger = false;
  DateTime _selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime _selectedYear = DateTime(
    DateTime.now().year,
  );

  final SQLiteHelper helper = SQLiteHelper();

  void itemUpdate(CheckListModel item) {
    //데이터 업데이트 하기
    helper.updateCheckItem(item);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              child: TableCalendar(
                rowHeight: 45,
                focusedDay: _selectedDay,
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
                onHeaderTapped: (focusedDay) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('연도 선택'),
                        content: Container(
                          width: 300,
                          height: 300,
                          child: YearPicker(
                            firstDate: DateTime(DateTime.now().year - 100, 1),
                            lastDate: DateTime(DateTime.now().year + 100, 1),
                            selectedDate: _selectedYear,
                            onChanged: (DateTime dateTime) {
                              focusedDay = DateTime(
                                  dateTime.year, //선택한 연도는 dateTime에 들어있음
                                  _selectedDay.month,
                                  _selectedDay.day);

                              _selectedDay = focusedDay; // 선택한 연도로 달력이 바뀌게 ...
                              Navigator.pop(context);
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                onDaySelected: (selectedDay, focusedDay) {
                  _selectedDay = DateTime(selectedDay.year, selectedDay.month,
                      selectedDay.day, 0, 0, 0);
                  setState(() {});
                },
              ),
            ),
            Container(
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
                  color: Color(0XFF999999),
                ),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    physics: _trigger
                        ? AlwaysScrollableScrollPhysics()
                        : NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                child: GestureDetector(
                                  onTap: () {
                                    context.go('/todo');
                                    ref
                                        .read(selectIndexProvider.notifier)
                                        .state = 0;
                                  },
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
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            '${_selectedDay.month}월 ${_selectedDay.day}일',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        checkList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Column achievementBar() {
    final selectColor = ref.watch(selectMainColorProvider);
    final selectSubColor = ref.watch(selectSubColorProvider);

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
          backgroundColor: selectSubColor,
          progressColor: selectColor,
          barRadius: Radius.circular(50),
        )
      ],
    );
  }

  Widget checkList() {
    //체크목록
    List<CheckListModel> checkItem = [
      // CheckListModel(checkable: false, content: '퇴근하기'),
      // CheckListModel(checkable: false, content: '퇴근하기1'),
      // CheckListModel(checkable: false, content: '퇴근하기2'),
      // CheckListModel(checkable: false, content: '퇴근하기3'),
      // CheckListModel(checkable: false, content: '퇴근하기4'),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: FutureBuilder<List<CheckListModel>>(
        future: helper.getAllCheckList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                '항목을 추가하세요.',
                style: TextStyle(color: Color(0XFF666666)),
              ),
            );
          } else {
            return ScrollConfiguration(
              //스크롤바 숨기기
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                // controller: _scrollController,
                child: Column(
                  children: snapshot.data!.mapIndexed((index, element) {
                    return CheckListItem(
                      index: index,
                      checkable: snapshot.data![index].checkable,
                      content: snapshot.data![index].content!,
                      listData: snapshot.data!,
                      itemUpdate: itemUpdate,
                    );
                  }).toList(),
                ),
              ),
            );
          }
        },
      ),
      // child: Column(
      //   children: checkItem.mapIndexed((index, element) {
      //     return CheckListItem(
      //       index: index,
      //       checkable: checkItem[index].checkable!,
      //       content: checkItem[index].content!,
      //     );
      //   }).toList(),
      // ),
    );
  }
}
