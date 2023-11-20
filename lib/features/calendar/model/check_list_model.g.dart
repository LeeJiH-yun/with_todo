// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CheckListModelImpl _$$CheckListModelImplFromJson(Map<String, dynamic> json) =>
    _$CheckListModelImpl(
      index: json['index'] as int?,
      checkable: json['checkable'] as bool?,
      content: json['content'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$$CheckListModelImplToJson(
        _$CheckListModelImpl instance) =>
    <String, dynamic>{
      'index': instance.index,
      'checkable': instance.checkable,
      'content': instance.content,
      'state': instance.state,
    };
