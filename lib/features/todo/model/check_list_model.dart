import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// part 'check_list_model.g.dart';
// part 'check_list_model.freezed.dart';

// @freezed
// class CheckListModel with _$CheckListModel {
//   factory CheckListModel({
//     bool? checkable,
//     String? content,
//     String? state,
//   }) = _CheckListModel;

//   factory CheckListModel.fromJson(Map<String, dynamic> json) =>
//       _$CheckListModelFromJson(json);
// }

class CheckListModel {
  late int? id;
  late int? checkable; //0: false, 1: true
  late String? content;
  late String? state; //N: 새로 추가, O: 이미 있던 거

  CheckListModel(
      {this.id,
      required this.checkable,
      required this.content,
      required this.state});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'checkable': checkable,
      'content': content,
      'state': state,
    };
  }

  CheckListModel.fromMap(Map<dynamic, dynamic>? map) {
    id = map?['id'];
    checkable = map?['checkable'];
    content = map?['content'];
    state = map?['state'];
  }
}
