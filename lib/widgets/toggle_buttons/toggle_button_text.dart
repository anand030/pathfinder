import 'package:flutter/material.dart';

import '../../utilities/consts/color_consts.dart';

class ToggleButtonText extends StatefulWidget {
  final String text;
  final void Function(bool) onSelected;
  final bool showBorder;
  final double borderRadius;

  const ToggleButtonText(
      {Key? key,
      required this.text,
      required this.onSelected,
      this.showBorder = true,
      this.borderRadius = 5})
      : super(key: key);

  @override
  State<ToggleButtonText> createState() => _ToggleButtonTextState();
}

class _ToggleButtonTextState extends State<ToggleButtonText> {
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
            border: Border.all(
                color: widget.showBorder
                    ? Palette.primaryColor
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: _isSelected
                ? Palette.primaryColor.withOpacity(0.2)
                : Colors.transparent),
        child: Text(
          widget.text,
          style: const TextStyle(color: Palette.primaryColor),
        ),
      ),
    );
  }
}
