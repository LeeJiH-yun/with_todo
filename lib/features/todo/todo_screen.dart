import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:with_todo/core/common/components/navigation_bar.dart';
import 'package:with_todo/core/common/provider/scrollbar_provider.dart';
import 'package:with_todo/features/calendar/model/check_list_model.dart';
import 'package:provider/provider.dart' as prefix;

final listChangeProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  List<CheckListModel> checkItem = [
    CheckListModel(checkable: false, content: '퇴근하기', state: 'O'),
    CheckListModel(checkable: false, content: '퇴근하기1', state: 'O'),
    CheckListModel(checkable: false, content: '퇴근하기2', state: 'O'),
    CheckListModel(checkable: false, content: '퇴근하기3', state: 'O'),
    CheckListModel(checkable: false, content: '퇴근하기4', state: 'O'),
  ];
  bool _isScroll = false;
  ScrollController _scrollController = ScrollController();
  TextEditingController _todoEditController = TextEditingController();

  @override
  void initState() {
    isScrollable();
    super.initState();
  }

  @override
  void dispose() {
    _todoEditController.dispose();
    super.dispose();
  }

  void isScrollable() async {
    await Future.delayed(Duration(milliseconds: 5));
    setState(() {
      _isScroll = _scrollController.position.maxScrollExtent != 0;
    });
  }

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
                '항목을 삭제하겠습니까?',
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
                    print('index $index');
                    checkItem.removeAt(index);
                    Navigator.pop(context);
                    setState(() {});
                    print(checkItem);
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
    DateTime todayDay = DateTime.now();
    String today = switch (todayDay.weekday) {
      1 => '월요일',
      2 => '화요일',
      3 => '수요일',
      4 => '목요일',
      5 => '금요일',
      6 => '토요일',
      _ => '일요일',
    };
    final listChange = ref.watch(listChangeProvider);

    return SizedBox(
      child: Padding(
        padding: EdgeInsets.only(
          left: 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '${todayDay.month}월 ${todayDay.day}일 $today',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ),
                Visibility(
                  visible: !listChange,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        checkItem.insert(
                          0,
                          CheckListModel(
                            checkable: false,
                            content: '내용을 입력하세요.',
                            state: 'N',
                          ),
                        );
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 180, right: 10),
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
                    ),
                  ),
                ),
                GestureDetector(
                  //목록 순서바꾸기
                  onTap: () {
                    ref.read(listChangeProvider.notifier).state = !listChange;
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
                        'assets/images/icon_order_change.png',
                      ),
                    ),
                  ),
                )
              ],
            ),
            prefix.ChangeNotifierProvider<VerticalScrollBarProvider>(
              create: (_) => VerticalScrollBarProvider(),
              child: prefix.Consumer<VerticalScrollBarProvider>(
                builder: (context, value, child) {
                  return Row(
                    children: [
                      NotificationListener<ScrollUpdateNotification>(
                        onNotification: ((notification) {
                          value.scrollListener(
                              notification: notification,
                              heightSize: 480 - 480 / 2);

                          return false;
                        }),
                        child: Expanded(
                          child: listChange
                              ? reorderListContainer()
                              : checkListContainer(),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: _isScroll || checkItem.length > 12,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Container(
                            //세로 스크롤바 구현
                            width: 10,
                            height: 480,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: value.scrollPosition,
                                  child: Container(
                                    width: 10,
                                    height: 480 / 2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        color: Colors.blue //Color(0XFFDDDDDD),
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget checkListContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 13),
      child: Container(
        height: 490,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Color(0XFFCCCCCC),
        ),
        child: ScrollConfiguration(
          //스크롤바 숨기기
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: checkItem.mapIndexed((index, element) {
                return CheckListItem(
                  index: index,
                  listData: checkItem,
                  state: checkItem[index].state!,
                  itemRemove: itemRemove,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget reorderListContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 13),
      child: Container(
        height: 490,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Color(0XFFCCCCCC),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ReorderableListView(
            children: [
              for (int index = 0; index < checkItem.length; index++)
                ListTile(
                  key: Key('$index'),
                  title: Text('${checkItem[index].content}'),
                ),
            ],
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final CheckListModel item = checkItem.removeAt(oldIndex);
                checkItem.insert(newIndex, item);
              });
            },
          ),
        ),
      ),
    );
  }
}

class CheckListItem extends ConsumerStatefulWidget {
  final int index;
  final List<CheckListModel> listData;
  final String state;
  final Function(int index) itemRemove;
  const CheckListItem(
      {super.key,
      required this.index,
      required this.listData,
      required this.state,
      required this.itemRemove});

  @override
  ConsumerState<CheckListItem> createState() => _CheckListItemState();
}

class _CheckListItemState extends ConsumerState<CheckListItem> {
  @override
  Widget build(BuildContext context) {
    final selectColor = ref.watch(selectMainColorProvider);
    final selectSubColor = ref.watch(selectSubColorProvider);
    print(widget.listData[widget.index].content);

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
              initialValue: widget.listData[widget.index].content,
              style: TextStyle(fontSize: 15, color: Colors.white),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(left: 12, right: 12, bottom: 14),
                focusedBorder: OutlineInputBorder(
                  //커서 올라갈 경우 밑줄 효과 없애기
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          'N' == widget.state ? selectColor : selectSubColor),
                ),
                fillColor: 'N' == widget.state ? selectColor : selectSubColor,
                filled: true,
                hintText: widget.listData[widget.index].content,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print(widget.index);
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
