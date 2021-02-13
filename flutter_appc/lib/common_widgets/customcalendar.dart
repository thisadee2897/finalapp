//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:relationship_app/app/home/models/account.dart';
// import 'package:relationship_app/common_widgets/calendarui.dart';
// import 'package:relationship_app/common_widgets/theme.dart';
//
//
// class CalendarDialog extends StatefulWidget {
//   final DateTime dateTime;
//
//   const CalendarDialog({Key key, this.dateTime}) : super(key: key);
//   @override
//   _CalendarDialogState createState() => _CalendarDialogState();
// }
//
// class _CalendarDialogState extends State<CalendarDialog> {
//   DateTime _currentDate;
//   DateTime _currentSelectDate;
//   String _currentMonth;
//
//   DateTime _targetDateTime;
//
//   @override
//   void initState() {
//     super.initState();
//     _currentMonth = _monthFormat(widget.dateTime);
//     _currentDate = widget.dateTime;
//     _currentSelectDate=widget.dateTime;
//     _targetDateTime=widget.dateTime;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: contentBox(context),
//       elevation: 0,
//     );
//   }
//
//   contentBox(BuildContext context) {
//     return Container(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _headerCalendar(),
//           _calendarTable(),
//           _bottomCalendar(context),
//         ],
//       ),
//     );
//   }
//   var heightCalendar;
//   _calendarTable() {
//     heightCalendar=350.0;
//     if(MediaQuery.of(context).size.width >600){
//       heightCalendar=700.0;
//     }
//
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//
//       child: CalendarCarousel(
//         onDayPressed: (DateTime date, List<Birthday> events) {
//           this.setState(() => _currentSelectDate = date);
//           // if (events.length > 0) {
//           //   _showBookingBottomSheet(events, _currentSelectDate);
//           // }
//           // events.forEach((event) => print(event.title));
//         },
//         locale: 'th',
//         showOnlyCurrentMonthDate: true,
//         // markedDateShowCountEvent: false,
//         weekendTextStyle: TextStyle(
//           color: Colors.black,
//         ),
//         weekFormat: false,
//         weekdayTextStyle: TextStyle(color: MyColors.primaryColorLight),
//         //  markedDatesMap: _markedDate,
//         height: heightCalendar,
//         selectedDayBorderColor: MyColors.primaryColorLight,
//         selectedDayButtonColor: MyColors.primaryColorLight,
//         selectedDateTime: _currentSelectDate,
//         targetDateTime: _targetDateTime,
//         customGridViewPhysics: NeverScrollableScrollPhysics(),
//         todayTextStyle: TextStyle(
//           color: MyColors.primaryColor,
//         ),
//         todayBorderColor: Colors.white,
//         todayButtonColor: Colors.white,
//         selectedDayTextStyle: TextStyle(
//           color: Colors.white,
//         ),
//         minSelectedDate: _currentDate.subtract(Duration(days: 360 * 10)),
//         maxSelectedDate: _currentDate.add(Duration(days: 360 * 10)),
//         inactiveDaysTextStyle: TextStyle(
//           color: Colors.black,
//           fontSize: 16,
//         ),
//         onCalendarChanged: (DateTime date) {
//           this.setState(() {
//             _targetDateTime = date;
//             _currentMonth = _monthFormat(_targetDateTime);
//
//
//           });
//         },
//         onDayLongPressed: (DateTime date) {
//           print('long pressed date $date');
//         },
//       ),
//     );
//   }
//
//   String _monthFormat(DateTime targetDateTime) {
//     return DateFormat("MMMM y", 'th')
//         .format(targetDateTime);
//   }
//
//   _headerCalendar() {
//     return Container(
//       margin: EdgeInsets.only(
//         top: 20.0,
//         bottom: 16.0,
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 16, right: 16),
//             child: new Row(
//               children: <Widget>[
//                 _titleCurrentMonth(),
//                 _leftButton(),
//                 _rightButton(),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Divider(
//             height: 1,
//             color: Colors.black26,
//           )
//         ],
//       ),
//     );
//   }
//
//   _leftButton() {
//     return InkWell(
//       borderRadius: BorderRadius.all(Radius.circular(100)),
//       onTap: () {
//         setState(() {
//           _targetDateTime =
//               DateTime(_targetDateTime.year, _targetDateTime.month - 1);
//           _currentMonth = _monthFormat(_targetDateTime);
//         });
//       },
//       child: Icon(
//         Icons.chevron_left,
//       ),
//     );
//   }
//
//   _titleCurrentMonth() {
//     return Expanded(
//         child: Text(
//           _currentMonth,
//           style: TextStyle(
//             fontSize: 19.0,
//           ),
//         ));
//   }
//
//   _rightButton() {
//     return InkWell(
//       borderRadius: BorderRadius.all(Radius.circular(100)),
//       child: Icon(
//         Icons.chevron_right,
//       ),
//       onTap: () {
//         setState(() {
//           _targetDateTime =
//               DateTime(_targetDateTime.year, _targetDateTime.month + 1);
//           _currentMonth = _monthFormat(_targetDateTime);
//         });
//       },
//     );
//   }
//
//   _bottomCalendar(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15,left: 15,right: 15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Flexible(
//           //   flex: 1,
//           //   child: CancelButton(
//           //     textColor: MyColors.primaryColor,
//           //     height: 50,
//           //     color: Colors.white,
//           //     borderColor: MyColors.primaryColor,
//           //     title: 'ย้อนกลับ',
//           //     onClick: (){Navigator.pop(context);},
//           //   ),
//           // ),
//           SizedBox(
//             width: 10,
//           ),
//           Flexible(
//             flex: 1,
//             child: OkButton(
//               height: 50,
//               color: MyColors.primaryColor,
//               title: 'ตกลง',
//               onClick: () {
//                 Navigator.pop(context,_currentSelectDate);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class OkButton extends StatelessWidget {
//   final String title;
//   final double width;
//   final Function onClick;
//   final Color color;
//   final double height;
//   final bool disabled;
//   const OkButton({Key key, @required this.title, this.width, @required this.onClick, this.color, this.height, this.disabled=false}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width??double.maxFinite,
//       height: height,
//       child: RaisedButton(
//         disabledColor:MyColors.primaryColorLight ,
//         color: color,
//
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(50),),
//         onPressed: disabled==false?onClick:null,
//         child:  Center(child: Text('$title',style: TextStyle(color: Colors.white),
//         ),
//         ),
//       ),
//     );
//
//   }
// }
// class CancelButton extends StatelessWidget {
//   final String title;
//   final double width;
//   final Function onClick;
//   final Color color;
//   final double height;
//   final bool disabled;
//   const CancelButton({Key key, @required this.title, this.width, @required this.onClick, this.color, this.height, this.disabled=false}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width??double.maxFinite,
//       height: height,
//       child: RaisedButton(
//         disabledColor:MyColors.primaryColorLight ,
//         color: color,
//
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(50),),
//         onPressed: disabled==false?onClick:null,
//         child:  Center(child: Text('$title',style: TextStyle(color: Colors.white),
//         ),
//         ),
//       ),
//     );
//
//   }
// }