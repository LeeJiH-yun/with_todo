import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:with_todo/features/calendar/model/check_list_model.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<CheckListModel> checkItem = [
    CheckListModel(index: 0, checkable: false, content: '퇴근하기', state: 'O'),
    CheckListModel(index: 1, checkable: false, content: '퇴근하기1', state: 'O'),
    CheckListModel(index: 2, checkable: false, content: '퇴근하기2', state: 'O'),
    CheckListModel(index: 3, checkable: false, content: '퇴근하기3', state: 'O'),
    CheckListModel(index: 4, checkable: false, content: '퇴근하기4', state: 'O'),
  ];

  void itemRemove(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            height: 80,
            child: Center(
              child: Text(
                '목록을 삭제하겠습니까?',
                style: TextStyle(
                  color: Color(0XFF666666),
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    checkItem.removeAt(index);
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0XFFEAE8E7),
                    ),
                    child: Center(
                      child: Text(
                        '녜',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0XFF4F4C49),
                    ),
                    child: Center(
                      child: Text(
                        '아니용',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '11월 15일 수요일',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        checkItem.insert(
                            0,
                            CheckListModel(
                                checkable: false,
                                content: '내용을 입력하세요.',
                                state: 'N'));
                      });
                    },
                    child: Container(
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
                    ),
                  )
                ],
              ),
            ),
            checkListContainer()
          ],
        ),
      ),
    );
  }

  Widget checkListContainer() {
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
            index: index,
            content: checkItem[index].content!,
            state: checkItem[index].state!,
            itemRemove: itemRemove,
          );
        }).toList(),
      ),
    );
  }
}

class CheckListItem extends StatefulWidget {
  final int index;
  final String content;
  final String state;
  final Function(int index) itemRemove;
  const CheckListItem(
      {super.key,
      required this.index,
      required this.content,
      required this.state,
      required this.itemRemove});

  @override
  State<CheckListItem> createState() => _CheckListItemState();
}

class _CheckListItemState extends State<CheckListItem> {
  @override
  Widget build(BuildContext context) {
    print(widget.index);

    return Padding(
      padding: EdgeInsets.only(
          top: widget.index == 0 ? 13 : 0, left: 13, right: 10, bottom: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 339,
            height: 30,
            child: TextFormField(
              style: TextStyle(
                fontSize: 18,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: 'N' == widget.state
                          ? Color(0XFF44ADF4)
                          : Colors.yellow),
                ),
                fillColor:
                    'N' == widget.state ? Color(0XFF44ADF4) : Colors.yellow,
                filled: true,
                hintText: widget.content,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.itemRemove(widget.index);
            },
            child: Container(
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
            ),
          )
        ],
      ),
    );
  }
}
