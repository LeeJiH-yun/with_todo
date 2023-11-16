import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:go_router/go_router.dart';
import 'package:with_todo/core/common/model/menu_model.dart';

final selectIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 1;
});

class NaviBarScreen extends ConsumerStatefulWidget {
  String location;

  final Widget child;

  NaviBarScreen({
    super.key,
    required this.child,
    required this.location,
  });

  @override
  ConsumerState<NaviBarScreen> createState() => _NaviBarScreenState();
}

class _NaviBarScreenState extends ConsumerState<NaviBarScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    print('widget location ${widget.location}');
    super.initState();
  }

  void itemClick(int index, BuildContext context, String url) {
    goNavigation(index, context, url);
    setState(() {});
  }

  void goNavigation(int index, BuildContext context, String url) async {
    context.go(url);
    ref.watch(selectIndexProvider.notifier).state = index;
    await Future.delayed(Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    List<MenuModel> menus = [
      MenuModel(
          index: 0,
          url: '/todo',
          title: '체크목록',
          img: 'assets/images/icon_todo.png',
          selectImg: 'assets/images/icon_todo_select.png'),
      MenuModel(
          index: 1,
          url: '/',
          title: '달력',
          img: 'assets/images/icon_calendar.png',
          selectImg: 'assets/images/icon_calendar_select.png'),
      MenuModel(
          index: 2,
          url: '/settings',
          title: '설정',
          img: 'assets/images/icon_setting.png',
          selectImg: 'assets/images/icon_setting_select.png')
    ];

    return Scaffold(
      backgroundColor: Color(0XFFF7F6F6),
      body: SizedBox(
        child: Column(
          children: [
            Container(
              //메뉴버튼
              height: 170,
              child: Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: menus.mapIndexed((index, element) {
                    return MenuItem(
                      index: index,
                      url: menus[index].url!,
                      imag: menus[index].img!,
                      selectImag: menus[index].selectImg!,
                      itemClick: itemClick,
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              //화면
              child: Container(
                child: widget.child,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MenuItem extends ConsumerStatefulWidget {
  final int index;
  final String url;
  final String imag;
  final String selectImag;
  const MenuItem({
    super.key,
    required this.index,
    required this.itemClick,
    required this.url,
    required this.imag,
    required this.selectImag,
  });

  final Function(int index, BuildContext context, String url) itemClick;

  @override
  ConsumerState<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends ConsumerState<MenuItem> {
  @override
  Widget build(BuildContext context) {
    final selectIndex = ref.watch(selectIndexProvider);

    return GestureDetector(
      onTap: () {
        widget.itemClick(widget.index, context, widget.url);
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color(0XFF666666).withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, 5),
            )
          ],
          color: widget.index == selectIndex
              ? Color(0XFF44ADF4)
              : Color(0XFFEFEFEF),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Image.asset(
              widget.index == selectIndex ? widget.selectImag : widget.imag),
        ),
      ),
    );
  }
}
