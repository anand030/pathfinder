import 'package:flutter/material.dart';

import '../../utilities/consts/color_consts.dart';

class PrimaryToggleButtonText extends StatefulWidget {
  final String text;
  final void Function(bool) onSelected;
  final double borderRadius;

  const PrimaryToggleButtonText(
      {Key? key,
      required this.text,
      required this.onSelected,
      this.borderRadius = 5})
      : super(key: key);

  @override
  State<PrimaryToggleButtonText> createState() =>
      _PrimaryToggleButtonTextState();
}

class _PrimaryToggleButtonTextState extends State<PrimaryToggleButtonText> {
  bool _isSelected = false;

  setIsSelected() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setIsSelected();
        widget.onSelected(_isSelected);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: _isSelected
                ? Palette.primaryColor
                : Palette.primaryColor.withOpacity(0.8)),
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Palette.white,
          ),
        ),
      ),
    );
  }
}
