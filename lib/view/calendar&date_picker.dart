import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';

class CalendarPages extends StatefulWidget {
  const CalendarPages({super.key});

  @override
  State<CalendarPages> createState() => _CalendarPagesState();
}

class _CalendarPagesState extends State<CalendarPages> {
  DateTime? selectedDate;
  final TextEditingController dateEditingController = TextEditingController();
  final TextEditingController nepaliDateController = TextEditingController();

  void openDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1888),
      lastDate: DateTime.now(),
    );

    setState(() {
      selectedDate = pickedDate;
      dateEditingController.text = DateFormat('yyyy-MM-dd').format(pickedDate!);

      // Convert to Nepali date immediately after selection
      // ignore: deprecated_member_use
      NepaliDateTime nepaliDate = NepaliDateTime.fromDateTime(pickedDate);
      nepaliDateController.text =
          '${nepaliDate.year}-${nepaliDate.month.toString().padLeft(2, '0')}-${nepaliDate.day.toString().padLeft(2, '0')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Page'),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: dateEditingController,
                  onTap: openDatePicker,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: 'Select Date',
                    suffixIconColor: Colors.pink,
                    suffixIcon: IconButton(
                      onPressed: openDatePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ),
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: nepaliDateController,
                  readOnly: true,
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: 'Nepali Date',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
