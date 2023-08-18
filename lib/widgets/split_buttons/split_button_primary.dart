import 'package:flutter/material.dart';

import '../../utilities/consts/color_consts.dart';

class SplitButtonPrimary extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final double width;
  final void Function(String) onItemSelected;

  const SplitButtonPrimary({
    Key? key,
    required this.items,
    required this.hintText,
    required this.onItemSelected,
    this.width = 250,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Palette.primaryColor,
          borderRadius: BorderRadius.circular(5.0)),
      width: width,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Palette.primaryColor),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        // style: const TextStyle(color: Colors.white),
        hint: Text(
          hintText,
          style: TextStyle(color: Colors.grey.shade200),
        ),
        dropdownColor: Palette.primaryColor,
        icon: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.only(right: 10),
              height: 100,
              width: 2,
              color: Colors.white,
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
            ),
          ],
        ),
        elevation: 16,
        onChanged: (String? newValue) {
          onItemSelected(newValue!);
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }
}
