import 'package:flutter/material.dart';

import '../../utilities/consts/color_consts.dart';

class PrimaryToggleButtonIcon extends StatefulWidget {
  final IconData icon;
  final void Function(bool) onSelected;
  final double borderRadius;

  const PrimaryToggleButtonIcon(
      {Key? key,
      required this.icon,
      required this.onSelected,
      this.borderRadius = 50})
      : super(key: key);

  @override
  State<PrimaryToggleButtonIcon> createState() =>
      _PrimaryToggleButtonIconState();
}

class _PrimaryToggleButtonIconState extends State<PrimaryToggleButtonIcon> {
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
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: _isSelected
                ? Palette.primaryColor
                : Palette.primaryColor.withOpacity(0.8)),
        child: Icon(
          widget.icon,
          color: Palette.white,
        ),
      ),
    );
  }
}
