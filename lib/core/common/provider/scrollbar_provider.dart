import 'package:flutter/material.dart';

//세로 스크롤바
class VerticalScrollBarProvider extends ChangeNotifier {
  double scrollPosition = 0.0;
  double shaderMaskvalue = 0.05; //스크롤을 다 했을 경우 경계선 흐리게 효과를 없애기 위함

  void scrollListener({
    required ScrollUpdateNotification notification,
    required double heightSize,
  }) {
    double _main = 0.0;

    _main = notification.metrics.maxScrollExtent / heightSize;
    scrollPosition = (notification.metrics.pixels / _main);
    shaderMaskvalue = notification.metrics.extentAfter > 0
        ? 0.05
        : 1; //스크롤이 끝에 도달하기 전:스크롤이 끝에 도달했을 경우
    notifyListeners();
  }
}
