import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:with_todo/core/common/components/navigation_bar.dart';
import 'package:with_todo/core/database_config.dart';
import 'package:with_todo/features/todo/model/check_list_model.dart';

class CheckListItem extends ConsumerStatefulWidget {
  final int index;
  final int? checkable;
  final List<CheckListModel> listData;
  final String content;
  final Function(CheckListModel item) itemUpdate;
  const CheckListItem({
    super.key,
    required this.index,
    this.checkable,
    required this.listData,
    required this.content,
    required this.itemUpdate,
  });

  @override
  ConsumerState<CheckListItem> createState() => _CheckListItemState();
}

class _CheckListItemState extends ConsumerState<CheckListItem> {
  bool _isCheck = false;

  final SQLiteHelper helper = SQLiteHelper();

  @override
  Widget build(BuildContext context) {
    final selectColor = ref.watch(selectMainColorProvider);
    final selectSubColor = ref.watch(selectSubColorProvider);

    return Row(
      children: [
        Checkbox(
          value: widget.checkable == 0 ? false : true,
          fillColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return selectColor;
            }
            return selectColor;
          }),
          checkColor: selectSubColor,
          onChanged: (value) {
            setState(() {
              // widget.checkable = value! == true ? 1 : 0;
              // _isCheck = value!;
              print('value $value');
              widget.listData[widget.index].checkable = value == false ? 0 : 1;
              widget.itemUpdate(widget.listData[widget.index]);
            });
          },
        ),
        widget.listData[widget.index].checkable == 1
            ? Text(
                '${widget.content}',
                style: TextStyle(
                  color: Color(0XFFCCCCCC),
                  decoration: TextDecoration.lineThrough,
                ),
              )
            : Text(
                '${widget.content}',
                style: TextStyle(color: Colors.white),
              ),
      ],
    );
  }
}
