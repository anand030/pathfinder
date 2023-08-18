import 'package:flutter/material.dart';

class SplitButton extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final double width;
  final void Function(String) onItemSelected;

  const SplitButton({
    Key? key,
    required this.items,
    required this.hintText,
    required this.onItemSelected,
    this.width = 250,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade600),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        hint: Text(hintText),
        icon: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.only(right: 10),
              height: 100,
              width: 2,
              color: Colors.grey.shade600,
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
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
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
