import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';

class DateOfBirthField extends StatefulWidget {
  final String savedLanguage;
  final String? selectedDate;
  final Function(String) selectedDateCallBack;
  const DateOfBirthField(
      {super.key,
      required this.savedLanguage,
      this.selectedDate,
      required this.selectedDateCallBack});

  @override
  State<DateOfBirthField> createState() => _DateOfBirthFieldState();
}

class _DateOfBirthFieldState extends State<DateOfBirthField> {
  late DateTime date;

  @override
  void didChangeDependencies() {
    if (widget.selectedDate != null) {
      date = DateFormat('yyyy/MM/dd').parse(widget.selectedDate!);
    } else {
      date = DateTime(1992, 05, 22);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: DatePickerWidget(
        firstDate: DateTime(1945, 01, 01),
        lastDate: DateTime(DateTime.now().year - 10, 1, 1),
        initialDate: date,
        dateFormat: "yyyy/MM/dd",
        locale: DatePicker.localeFromString(widget.savedLanguage),
        onChange: (DateTime newDate, _) {
          widget.selectedDateCallBack(DateFormat("yyyy/MM/dd").format(newDate));
        },
        pickerTheme: const DateTimePickerTheme(
          itemTextStyle: TextStyle(color: Color(0xff384048), fontSize: 15),
        ),
      ),
    );
  }
}
