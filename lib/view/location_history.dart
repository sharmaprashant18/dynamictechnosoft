import 'package:dotted_line/dotted_line.dart';
import 'package:dynamictechnosoft/model/google_map_history_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';

class LocationHistoryScreen extends StatefulWidget {
  final List<LocationData> locationHistoryScreen;

  const LocationHistoryScreen({super.key, required this.locationHistoryScreen});

  @override
  State<LocationHistoryScreen> createState() => _LocationHistoryScreenState();
}

class _LocationHistoryScreenState extends State<LocationHistoryScreen> {
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

      NepaliDateTime nepaliDate = NepaliDateTime.now();
      nepaliDateController.text =
          '${nepaliDate.year}-${nepaliDate.month.toString().padLeft(2, '0')}-${nepaliDate.day.toString().padLeft(2, '0')}';
    });
  }

  String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
  }

  String formatDate(DateTime day) {
    return DateFormat('MMM').format(day);
  }

  String formatDay(DateTime) {
    return '${DateTime.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F0F0),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            TextFormField(
              textAlign: TextAlign.center,
              controller: dateEditingController,
              onTap: openDatePicker,
              readOnly: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                hintText: 'Select Date',
                // suffixIconColor: Colors.pink,
                suffixIcon: IconButton(
                  onPressed: openDatePicker,
                  icon: Icon(Icons.calendar_month),
                ),
              ),
              // style: TextStyle(fontSize: 30),
            ),
          ],
        ),
        // backgroundColor: Colors.lightGreenAccent,
        backgroundColor: Color(0xffF0F0F0),

        centerTitle: true,
      ),
      body: Container(
        child: widget.locationHistoryScreen.isEmpty
            ? Center(child: Text("No location data available"))
            : ListView.builder(
                itemCount: widget.locationHistoryScreen.length,
                itemBuilder: (context, index) {
                  final loc = widget.locationHistoryScreen[index];
                  final isFirst = index == 0;
                  // final isLast =index == widget.locationHistoryScreen.length - 1;
                  final isMiddle = index % 2 == 0;
                  return ListTile(
                    title: Container(
                      child: Column(
                        children: [
                          if (isFirst)
                            Text(
                                ' ${formatDate(loc.timestap)}'
                                ' ${formatDay(loc.timestap)}:'
                                ' Location History',
                                style: TextStyle(fontWeight: FontWeight.bold))
                          else
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: SizedBox(
                                    height: 45,
                                    child: Column(
                                      children: [
                                        Card(
                                          // color: Colors.grey.shade50,
                                          surfaceTintColor: isMiddle
                                              ? Colors.black
                                              : Colors.green,
                                          shadowColor: Colors.blue.withBlue(2),
                                          elevation: 4,
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.watch_later,
                                                size: 17,
                                                color: Colors.grey,
                                              ),
                                              Text(formatTime(loc.timestap))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 45,
                                  height: 2,
                                  color: isMiddle ? Colors.black : Colors.green,
                                ),
                                Container(
                                  height: 70,
                                  width: 255,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.grey.withValues(alpha: 0.3),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.deepPurpleAccent,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Icon(Icons.location_on),
                                        ),
                                        SizedBox(
                                          height:
                                              70, //adjust the height of the dot if needed/accordingly
                                          child: DottedLine(
                                            direction: Axis.vertical,
                                            lineThickness: 2,
                                            dashLength: 3,
                                            dashColor: isMiddle
                                                ? Colors.green
                                                : Colors.indigo,
                                          ),
                                        ),
                                        Container(
                                          color: Colors.red,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              loc.locationName,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}





 // return InkWell(
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: Column(
                  //     children: [
                  // isFirst
                  //     ? Text(
                  //         ' ${formatDate(loc.timestap)}'
                  //         ' ${formatDay(loc.timestap)}:'
                  //         ' Location History',
                  //         style: TextStyle(fontWeight: FontWeight.bold))
                  //     : Row(
                  //               children: [
                  //                 SizedBox(width: 8),
                  //                 SizedBox(
                  //                   width: 80,
                  //                   child: Column(
                  //                     children: [
                  //                       Container(
                  //                         width: 2,
                  //                         height: 65,
                  //                         color: isMiddle
                  //                             ? Colors.green
                  //                             : Colors.grey,
                  //                       ),
                  //                       SizedBox(
                  //                         height: 50,
                  //                         width: 90,
                  // child: Card(
                  //   surfaceTintColor: Colors.green,
                  //   shadowColor: Colors.blue,
                  //   elevation: 7,
                  //   child: Column(
                  //     children: [
                  //       Icon(
                  //         Icons.watch_later,
                  //         size: 17,
                  //         color: Colors.grey,
                  //       ),
                  //       Text(formatTime(loc.timestap))
                  //     ],
                  //   ),
                  // ),
                  //                       ),
                  //                       Container(
                  //                         width: 2,
                  //                         height: 20,
                  //                         color:
                  //                             isLast ? Colors.red : Colors.grey,
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 Expanded(
                  //                   child: Container(
                  //                     child: Card(
                  //                       shadowColor: Colors.teal,
                  //                       surfaceTintColor: Colors.grey,
                  //                       elevation: 5,
                  //                       color: Colors.white,
                  //                       child: Padding(
                  //                         padding: const EdgeInsets.all(40),
                  //                         child: Column(
                  //                           children: [
                  //                             Row(
                  //                               children: [
                  //                                 Container(
                  //                                   decoration: BoxDecoration(
                  //                                     borderRadius:
                  //                                         BorderRadius.circular(
                  //                                             10),
                  //                                     color: Colors.blue
                  //                                         .withAlpha(50),
                  //                                   ),
                  //                                   child: Icon(
                  //                                     Icons.location_on,
                  //                                     color: Colors.blue,
                  //                                   ),
                  //                                 ),
                  //                                 SizedBox(width: 10),
                  //                                 Flexible(
                  //                                   child: Text(
                  //                                     loc.locationName,
                  //                                     style: TextStyle(
                  //                                         fontWeight:
                  //                                             FontWeight.w600),
                  //                                     overflow:
                  //                                         TextOverflow.ellipsis,
                  //                                   ),
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                             SizedBox(height: 7),
                  //                             // Row(
                  //                             // children: [
                  //                             // Icon(
                  //                             //   Icons.watch_later,
                  //                             //   size: 17,
                  //                             //   color: Colors.grey,
                  //                             // ),
                  //                             // SizedBox(width: 5),
                  //                             // Text(
                  //                             //   formatTime(loc.timestap),
                  //                             //   style: const TextStyle(
                  //                             //     color: Colors.black,
                  //                             //   ),
                  //                             // ),
                  //                             // ],
                  //                             // )
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //     ],
                  //   ),
                  // );