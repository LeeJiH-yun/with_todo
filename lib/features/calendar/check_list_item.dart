import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:with_todo/core/common/components/navigation_bar.dart';

class CheckListItem extends ConsumerStatefulWidget {
  final int index;
  final bool? checkable;
  final String content;
  const CheckListItem(
      {super.key, required this.index, this.checkable, required this.content});

  @override
  ConsumerState<CheckListItem> createState() => _CheckListItemState();
}

class _CheckListItemState extends ConsumerState<CheckListItem> {
  bool _isCheck = false;

  @override
  Widget build(BuildContext context) {
    final selectColor = ref.watch(selectMainColorProvider);
    final selectSubColor = ref.watch(selectSubColorProvider);

    return Row(
      children: [
        Checkbox(
          value: _isCheck, //widget.checkable,
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
              //widget.checkable = value!;
              _isCheck = value!;
            });
          },
        ),
        Text(
          '${widget.content}',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
