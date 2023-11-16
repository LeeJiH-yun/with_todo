import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_model.g.dart';
part 'menu_model.freezed.dart';

@freezed
class MenuModel with _$MenuModel {
  factory MenuModel({
    int? index,
    String? url,
    String? title,
    String? img,
    String? selectImg,
  }) = _MenuModel;

  factory MenuModel.fromJson(Map<String, dynamic> json) =>
      _$MenuModelFromJson(json);
}
