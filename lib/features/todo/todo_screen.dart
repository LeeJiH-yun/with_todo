import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:with_todo/features/calendar/model/check_list_model.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '11월 15일 수요일',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Color(0XFF666666),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Image.asset(
                      'assets/images/icon_plus.png',
                    ),
                  ),
                )
              ],
            ),
            checkListContainer()
          ],
        ),
      ),
    );
  }

  Widget checkListContainer() {
    List<CheckListModel> checkItem = [
      CheckListModel(index: 0, checkable: false, content: '퇴근하기'),
      CheckListModel(index: 1, checkable: false, content: '퇴근하기1'),
      CheckListModel(index: 2, checkable: false, content: '퇴근하기2'),
      CheckListModel(index: 3, checkable: false, content: '퇴근하기3'),
      CheckListModel(index: 4, checkable: false, content: '퇴근하기4'),
    ];

    return Container(
      height: 490,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: Color(0XFFCCCCCC),
      ),
      child: Column(
        children: checkItem.mapIndexed((index, element) {
          return CheckListItem(
              index: index, content: checkItem[index].content!);
        }).toList(),
      ),
    );
  }
}

class CheckListItem extends StatefulWidget {
  final int index;
  final String content;
  const CheckListItem({super.key, required this.index, required this.content});

  @override
  State<CheckListItem> createState() => _CheckListItemState();
}

class _CheckListItemState extends State<CheckListItem> {
  bool _isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: widget.index == 0 ? 13 : 0, left: 13, right: 10, bottom: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 339,
            height: 30,
            color: Colors.amber,
            child: Text(
              '${widget.content}',
              style: TextStyle(
                color: Color(0XFF999999),
                fontSize: 18,
              ),
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color(0XFF666666),
            ),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Image.asset(
                'assets/images/icon_minus.png',
              ),
            ),
          )
        ],
      ),
    );
  }
}
