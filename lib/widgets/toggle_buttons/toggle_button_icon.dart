import 'package:flutter/material.dart';

import '../../utilities/consts/color_consts.dart';

class ToggleButtonIcon extends StatefulWidget {
  final IconData icon;
  final void Function(bool) onSelected;
  final bool showBorder;
  final double borderRadius;

  const ToggleButtonIcon(
      {Key? key,
      required this.icon,
      required this.onSelected,
      this.showBorder = true,
      this.borderRadius = 50})
      : super(key: key);

  @override
  State<ToggleButtonIcon> createState() => _ToggleButtonIconState();
}

class _ToggleButtonIconState extends State<ToggleButtonIcon> {
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
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(
                color: widget.showBorder
                    ? Palette.primaryColor
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: _isSelected
                ? Palette.primaryColor.withOpacity(0.2)
                : Colors.transparent),
        child: Icon(
          widget.icon,
          color: Palette.primaryColor,
        ),
      ),
    );
  }
}
