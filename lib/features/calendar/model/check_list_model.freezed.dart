// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CheckListModel _$CheckListModelFromJson(Map<String, dynamic> json) {
  return _CheckListModel.fromJson(json);
}

/// @nodoc
mixin _$CheckListModel {
  int? get index => throw _privateConstructorUsedError;
  bool? get checkable => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckListModelCopyWith<CheckListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckListModelCopyWith<$Res> {
  factory $CheckListModelCopyWith(
          CheckListModel value, $Res Function(CheckListModel) then) =
      _$CheckListModelCopyWithImpl<$Res, CheckListModel>;
  @useResult
  $Res call({int? index, bool? checkable, String? content});
}

/// @nodoc
class _$CheckListModelCopyWithImpl<$Res, $Val extends CheckListModel>
    implements $CheckListModelCopyWith<$Res> {
  _$CheckListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = freezed,
    Object? checkable = freezed,
    Object? content = freezed,
  }) {
    return _then(_value.copyWith(
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      checkable: freezed == checkable
          ? _value.checkable
          : checkable // ignore: cast_nullable_to_non_nullable
              as bool?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckListModelImplCopyWith<$Res>
    implements $CheckListModelCopyWith<$Res> {
  factory _$$CheckListModelImplCopyWith(_$CheckListModelImpl value,
          $Res Function(_$CheckListModelImpl) then) =
      __$$CheckListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? index, bool? checkable, String? content});
}

/// @nodoc
class __$$CheckListModelImplCopyWithImpl<$Res>
    extends _$CheckListModelCopyWithImpl<$Res, _$CheckListModelImpl>
    implements _$$CheckListModelImplCopyWith<$Res> {
  __$$CheckListModelImplCopyWithImpl(
      _$CheckListModelImpl _value, $Res Function(_$CheckListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = freezed,
    Object? checkable = freezed,
    Object? content = freezed,
  }) {
    return _then(_$CheckListModelImpl(
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      checkable: freezed == checkable
          ? _value.checkable
          : checkable // ignore: cast_nullable_to_non_nullable
              as bool?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckListModelImpl implements _CheckListModel {
  _$CheckListModelImpl({this.index, this.checkable, this.content});

  factory _$CheckListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckListModelImplFromJson(json);

  @override
  final int? index;
  @override
  final bool? checkable;
  @override
  final String? content;

  @override
  String toString() {
    return 'CheckListModel(index: $index, checkable: $checkable, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckListModelImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.checkable, checkable) ||
                other.checkable == checkable) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, index, checkable, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckListModelImplCopyWith<_$CheckListModelImpl> get copyWith =>
      __$$CheckListModelImplCopyWithImpl<_$CheckListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckListModelImplToJson(
      this,
    );
  }
}

abstract class _CheckListModel implements CheckListModel {
  factory _CheckListModel(
      {final int? index,
      final bool? checkable,
      final String? content}) = _$CheckListModelImpl;

  factory _CheckListModel.fromJson(Map<String, dynamic> json) =
      _$CheckListModelImpl.fromJson;

  @override
  int? get index;
  @override
  bool? get checkable;
  @override
  String? get content;
  @override
  @JsonKey(ignore: true)
  _$$CheckListModelImplCopyWith<_$CheckListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
