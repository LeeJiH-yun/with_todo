import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:with_todo/core/common/components/navigation_bar.dart';
import 'package:with_todo/core/common/model/todo.dart';
import 'package:with_todo/core/common/provider/scrollbar_provider.dart';
import 'package:with_todo/core/database_config.dart';
import 'package:provider/provider.dart' as prefix;
import 'package:with_todo/features/todo/model/check_list_model.dart';

final listChangeProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
final textChangeProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  bool _isScroll = false;
  ScrollController _scrollController = ScrollController();
  // final DatabaseService _databaseService = DatabaseService();
  // Future<List<CheckListModel>> _todoList = ;
  List<CheckListModel> _todoList = [];
  // DatabaseService()
  //     .databaseConfig()
  //     .then((value) => DatabaseService().selectTodos());
  int currentCount = 0;

  final SQLiteHelper helper = SQLiteHelper();

  @override
  void initState() {
    // isScrollable();
    super.initState();
    helper.initWinDB();
  }

  void isScrollable() async {
    await Future.delayed(Duration(milliseconds: 5));
    setState(() {
      _isScroll = _scrollController.position.maxScrollExtent != 0;
    });
  }

  void itemRemove(int id) {
    //데이터 삭제하기
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
                  onTap: () async {
                    // checkItem.removeAt(index);
                    await helper.deleteCheckItem(id);
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

  void itemUpdate(CheckListModel item) {
    //데이터 업데이트 하기
    helper.updateCheckItem(item);
    setState(() {});
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
                        helper.insertCheckItem(CheckListModel(
                          checkable: 0, //0: false, 1: true
                          content: '',
                          state: 'N',
                        ));
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 150, right: 10),
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
                Visibility(
                  visible: true, //checkItem.length == 0 ? false :
                  child: GestureDetector(
                    //목록 순서바꾸기
                    onTap: () {
                      ref.read(listChangeProvider.notifier).state = !listChange;
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color:
                            listChange ? Color(0XFF999999) : Color(0XFF666666),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Image.asset(
                          'assets/images/icon_order_change.png',
                        ),
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
                        visible: _isScroll, // || checkItem.length > 12
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
      child: GestureDetector(
        onTap: () {
          ref.read(textChangeProvider.notifier).state = false;
        },
        child: Container(
            height: 490,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Color(0XFFCCCCCC),
            ),
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
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: snapshot.data!.mapIndexed((index, element) {
                          return CheckListItem(
                            index: index,
                            listData: snapshot.data!,
                            state: snapshot.data![index].state!,
                            itemRemove: itemRemove,
                            itemUpdate: itemUpdate,
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }
              },
            )
            // child: FutureBuilder(
            //   future: _todoList,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       currentCount = snapshot.data!.length;
            //       if (currentCount == 0) {
            //         return Center(
            //             child: Text(
            //           '항목을 추가하세요.',
            //           style: TextStyle(color: Color(0XFF666666)),
            //         ));
            //       } else {
            //         return ScrollConfiguration(
            //           //스크롤바 숨기기
            //           behavior: ScrollConfiguration.of(context)
            //               .copyWith(scrollbars: false),
            //           child: SingleChildScrollView(
            //             controller: _scrollController,
            //             child: Column(
            //               children: snapshot.data!.mapIndexed((index, element) {
            //                 return CheckListItem(
            //                   index: index,
            //                   listData: snapshot.data!,
            //                   state: snapshot.data![index].state!,
            //                   itemRemove: itemRemove,
            //                 );
            //               }).toList(),
            //             ),
            //           ),
            //         );
            //       }
            //     } else if (snapshot.hasError) {
            //       return Center(
            //         child: Text('ERROR'),
            //       );
            //     } else {
            //       return Center(
            //         child: CircularProgressIndicator(
            //           strokeWidth: 2,
            //         ),
            //       );
            //     }
            //   },
            // ),
            // child: _todoList.length == 0
            //     ? Center(
            //         child: Text(
            //         '항목을 추가하세요.',
            //         style: TextStyle(color: Color(0XFF666666)),
            //       ))
            //     : ScrollConfiguration(
            //         //스크롤바 숨기기
            //         behavior: ScrollConfiguration.of(context)
            //             .copyWith(scrollbars: false),
            //         child: SingleChildScrollView(
            //           controller: _scrollController,
            //           child: Column(
            //             children: _todoList.mapIndexed((index, element) {
            //               return CheckListItem(
            //                 index: index,
            //                 listData: _todoList,
            //                 state: _todoList[index].state!,
            //                 itemRemove: itemRemove,
            //               );
            //             }).toList(),
            //           ),
            //         ),
            //       ),
            ),
      ),
    );
  }

  Widget reorderListContainer() {
    //데이터 재배치하기
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
              // for (int index = 0; index < checkItem.length; index++)
              //   ListTile(
              //     key: Key('$index'),
              //     title: Text('${checkItem[index].content}'),
              //   ),
            ],
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                // final CheckListModel item = checkItem.removeAt(oldIndex);
                // checkItem.insert(newIndex, item);
              });
            },
          ),
        ),
      ),
    );
  }
}

class CheckListItem extends ConsumerStatefulWidget {
  //각 목록
  final int index;
  final List<CheckListModel> listData;
  final String state;
  final Function(int id) itemRemove;
  final Function(CheckListModel item) itemUpdate;
  const CheckListItem({
    super.key,
    required this.index,
    required this.listData,
    required this.state,
    required this.itemRemove,
    required this.itemUpdate,
  });

  @override
  ConsumerState<CheckListItem> createState() => _CheckListItemState();
}

class _CheckListItemState extends ConsumerState<CheckListItem> {
  late TextEditingController _todoEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _todoEditController =
        TextEditingController(text: widget.listData[widget.index].content);
  }

  @override
  void dispose() {
    _todoEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectColor = ref.watch(selectMainColorProvider);
    final selectSubColor = ref.watch(selectSubColorProvider);
    final textChange = ref.watch(textChangeProvider);

    _todoEditController =
        TextEditingController(text: widget.listData[widget.index].content);

    return Padding(
      padding: EdgeInsets.only(
          top: widget.index == 0 ? 13 : 0, left: 13, right: 10, bottom: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              ref.read(textChangeProvider.notifier).state = true;
            },
            child: Container(
                width: 300,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: 'N' == widget.state ? selectColor : selectSubColor,
                ),
                child: textChange
                    ? TextFormField(
                        controller: _todoEditController,
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
                                color: 'N' == widget.state
                                    ? selectColor
                                    : selectSubColor),
                          ),
                          fillColor: 'N' == widget.state
                              ? selectColor
                              : selectSubColor,
                          filled: true,
                          hintText: '내용을 입력하세요.',
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: 5, left: 12, right: 12),
                        child: Text(
                          '${widget.listData[widget.index].content}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0XFF777777),
                          ),
                        ))),
          ),
          GestureDetector(
            //삭제
            onTap: () {
              widget.itemRemove(widget.listData[widget.index].id!);
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
          ),
          GestureDetector(
            //수정
            onTap: () {
              widget.listData[widget.index].content =
                  _todoEditController.text; //내용 수정해서 넣어준당
              widget.listData[widget.index].state = 'O'; //수정했으니 기존에 있는 상태로
              widget.itemUpdate(widget.listData[widget.index]);
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.amber,
              ),
              child: Icon(Icons.check),
            ),
          )
        ],
      ),
    );
  }
}
