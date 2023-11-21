import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:with_todo/core/common/components/navigation_bar.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  bool _isChecked = false;
  Color _color = Color(0XFF44ADF4);
  Color _subColor = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    final selectMainColor = ref.watch(selectMainColorProvider);
    final selectSubColor = ref.watch(selectSubColorProvider);

    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '알람 설정',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  CupertinoSwitch(
                    value: _isChecked,
                    activeColor: selectMainColor,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isChecked,
              child: SizedBox(
                height: 20,
              ),
            ),
            Visibility(
              visible: _isChecked,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '알람 시간',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: 8, minute: 0),
                      );
                    },
                    child: Text(
                      '오전 08:00',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFFCCCCCC)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '기본 색상',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Container(
                  width: 80,
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: _color,
                                      onColorChanged: (Color color) {
                                        setState(() {
                                          _color = color;
                                          ref
                                              .read(selectMainColorProvider
                                                  .notifier)
                                              .state = color;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: selectMainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: _subColor,
                                      onColorChanged: (Color color) {
                                        setState(() {
                                          _subColor = color;
                                          ref
                                              .read(selectSubColorProvider
                                                  .notifier)
                                              .state = color;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: selectSubColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              color: Color(0XFF999999),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '계정 연동',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'jihyunlee1315@gmail.com',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFFCCCCCC)),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: Color(0XFF999999),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                '앱 평가하기',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
