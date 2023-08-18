import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final void Function(String) onDateSelected;

  const DatePicker({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController dateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dateInput,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.calendar_today),
          labelText: "Select Date"),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime(2100));

        if (pickedDate != null) {
          var formattedDate = formatDate(pickedDate, [dd, '-', mm, '-', yyyy]);
          widget.onDateSelected(formattedDate);
          setState(() {
            dateInput.text = formattedDate;
          });
        }
      },
    );
  }
}
