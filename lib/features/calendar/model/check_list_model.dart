import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_list_model.g.dart';
part 'check_list_model.freezed.dart';

@freezed
class CheckListModel with _$CheckListModel {
  factory CheckListModel({
    int? index,
    bool? checkable,
    String? content,
    String? state,
  }) = _CheckListModel;

  factory CheckListModel.fromJson(Map<String, dynamic> json) =>
      _$CheckListModelFromJson(json);
}
