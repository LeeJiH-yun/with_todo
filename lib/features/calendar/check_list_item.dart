import 'package:flutter/material.dart';

class CheckListItem extends StatefulWidget {
  final int index;
  final bool checkable;
  final String content;
  const CheckListItem(
      {super.key,
      required this.index,
      required this.checkable,
      required this.content});

  @override
  State<CheckListItem> createState() => _CheckListItemState();
}

class _CheckListItemState extends State<CheckListItem> {
  bool _isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.checkable,
          onChanged: (value) {
            setState(() {
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
