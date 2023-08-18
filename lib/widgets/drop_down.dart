import 'package:flutter/material.dart';

class DropDownItems extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final void Function(String) onItemSelected;

  const DropDownItems({
    Key? key,
    required this.items,
    required this.hintText,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade600),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      // value: value,
      hint: Text(hintText),
      icon: const Icon(Icons.keyboard_arrow_down_rounded,),
      elevation: 16,
      onChanged: (String? newValue) {
        onItemSelected(newValue!);
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
