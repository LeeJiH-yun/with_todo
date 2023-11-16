import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<BottomNavBarItem> tabs = [
      BottomNavBarItem(
        initialLocation: '/todo',
        icon: BottomContainerItem(index: 0, img: 'assets/images/ic_menu1.png'),
        label: '',
        activeIcon: BottomContainerItem(
            index: 0, active: true, img: 'assets/images/ic_menu1_selected.png'),
      ),
      BottomNavBarItem(
        initialLocation: '/',
        icon: BottomContainerItem(index: 1, img: 'assets/images/ic_menu2.png'),
        label: '',
        activeIcon: BottomContainerItem(
            index: 1, active: true, img: 'assets/images/ic_menu2_selected.png'),
      ),
      BottomNavBarItem(
        initialLocation: '/settings',
        icon: BottomContainerItem(index: 2, img: 'assets/images/ic_menu3.png'),
        label: '',
        activeIcon: BottomContainerItem(
            index: 2, active: true, img: 'assets/images/ic_menu3_selected.png'),
      ),
    ];

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size.width / 17),
            topRight: Radius.circular(size.width / 17),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0XFF666666).withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 30,
              offset: Offset(0, 10),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size.width / 17),
            topRight: Radius.circular(size.width / 17),
          ),
          child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Color(0XFFEAE8E7),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 0,
              unselectedFontSize: 0,
              type: BottomNavigationBarType.fixed,
              onTap: (int index) {
                String location = tabs[index].initialLocation;

                setState(() {
                  _currentIndex = index;
                });
                context.go(location);
              },
              currentIndex: widget.location == '/todo'
                  ? 0
                  : widget.location == '/'
                      ? 1
                      : 2,
              items: tabs),
        ),
      ),
    );
  }
}

class BottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const BottomNavBarItem({
    required this.initialLocation,
    required Widget icon,
    required Widget activeIcon,
    String? label,
  }) : super(icon: icon, activeIcon: activeIcon, label: label);
}

class BottomContainerItem extends ConsumerStatefulWidget {
  final int index;
  final String img;
  final bool? active;
  const BottomContainerItem({
    super.key,
    required this.index,
    required this.img,
    this.active = false,
  });

  @override
  ConsumerState<BottomContainerItem> createState() =>
      _BottomContainerItemState();
}

class _BottomContainerItemState extends ConsumerState<BottomContainerItem> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(right: widget.index == 4 ? 0 : 1.5),
      child: Container(
        width: size.width / 5,
        height: size.height / 8.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: widget.active == true ? Color(0XFF4F4C49) : Color(0XFFFFFFFF),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: size.height / 43),
          child: Container(
            height: size.height / 15,
            child: Text(
              'test',
              style: TextStyle(
                fontSize: size.width / 23,
                fontWeight:
                    widget.active == true ? FontWeight.w700 : FontWeight.w600,
                height: 1.4,
                color: widget.active == true
                    ? Color(0XFFEAEAEA)
                    : Color(0XFF8B8885),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
