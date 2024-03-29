// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart' show DateFormat;
//
//
// typedef MarkedDateIconBuilder<T> = Widget Function(T event);
// typedef void OnDayLongPressed(DateTime day);
//
// /// This builder is called for every day in the calendar.
// /// If you want to build only few custom day containers, return null for the days you want to leave with default looks
// /// All characteristics like circle border are also applied to the custom day container [DayBuilder] provides.
// /// (if supplied function returns null, Calendar's function will be called for [day]).
// /// [isSelectable] - is between [CalendarCarousel.minSelectedDate] and [CalendarCarousel.maxSelectedDate]
// /// [index] - DOES NOT equal day number! Index of the day built in current visible field
// /// [isSelectedDay] - if the day is selected
// /// [isToday] - if the day is similar to [DateTime.now()]
// /// [isPrevMonthDay] - if the day is from previous month
// /// [textStyle] - text style that would have been applied by the calendar if it was to build the day.
// /// Example: if the user provided [CalendarCarousel.todayTextStyle] and [isToday] is true,
// ///   [CalendarCarousel.todayTextStyle] would be sent into [DayBuilder]'s [textStyle]. If user didn't
// ///   provide it, default [CalendarCarousel]'s textStyle would be sent. Same applies to all text styles like
// ///   [CalendarCarousel.prevDaysTextStyle], [CalendarCarousel.daysTextStyle] etc.
// /// [isNextMonthDay] - if the day is from next month
// /// [isThisMonthDay] - if the day is from next month
// /// [day] - day being built.
// typedef Widget DayBuilder(
//     bool isSelectable,
//     int index,
//     bool isSelectedDay,
//     bool isToday,
//     bool isPrevMonthDay,
//     TextStyle textStyle,
//     bool isNextMonthDay,
//     bool isThisMonthDay,
//     DateTime day);
//
// /// This builder is called for every weekday container (7 times, from Mon to Sun).
// /// [weekday] - weekday built, from 0 to 6.
// /// [weekdayName] - string representation of the weekday (Mon, Tue, Wed, etc).
// typedef Widget WeekdayBuilder(int weekday, String weekdayName);
//
// class CalendarCarousel extends StatefulWidget {
//   final double viewportFraction;
//   final TextStyle prevDaysTextStyle;
//   final TextStyle daysTextStyle;
//   final TextStyle nextDaysTextStyle;
//   final Color prevMonthDayBorderColor;
//   final Color thisMonthDayBorderColor;
//   final Color nextMonthDayBorderColor;
//   final double dayPadding;
//   final double height;
//   final double width;
//   final TextStyle todayTextStyle;
//   final Color dayButtonColor;
//   final Color todayBorderColor;
//   final Color todayButtonColor;
//   final DateTime selectedDateTime;
//   final DateTime targetDateTime;
//   final TextStyle selectedDayTextStyle;
//   final Color selectedDayButtonColor;
//   final Color selectedDayBorderColor;
//   final Function(DateTime, List<MatchEvent>) onDayPressed;
//   final TextStyle weekdayTextStyle;
//   final Color iconColor;
//   final TextStyle headerTextStyle;
//   final String headerText;
//   final TextStyle weekendTextStyle;
//   final EventList<MatchEvent> markedDatesMap;
//
//   /// Change `makredDateWidget` when `markedDateShowIcon` is set to false.
//   final Widget markedDateWidget;
//
//   /// Change `ShapeBorder` when `markedDateShowIcon` is set to false.
//   final ShapeBorder markedDateCustomShapeBorder;
//
//   /// Change `TextStyle` when `markedDateShowIcon` is set to false.
//   final TextStyle markedDateCustomTextStyle;
//
//   /// Icon will overlap the [Day] widget when `markedDateShowIcon` is set to true.
//   /// This will also make below parameters work.
//   final bool markedDateShowCountEvent;
//   final Color markedDateIconBorderColor;
//   final int markedDateIconMaxShown;
//   final double markedDateIconMargin;
//   final double markedDateIconOffset;
//
//
//   /// null - no indicator, true - show the total events, false - show the total of hidden events
//   final bool markedDateMoreShowTotal;
//   final Decoration markedDateMoreCustomDecoration;
//   final TextStyle markedDateMoreCustomTextStyle;
//   final EdgeInsets headerMargin;
//   final double childAspectRatio;
//   final EdgeInsets weekDayMargin;
//   final EdgeInsets weekDayPadding;
//   final WeekdayBuilder customWeekDayBuilder;
//   final DayBuilder customDayBuilder;
//   final Color weekDayBackgroundColor;
//   final bool weekFormat;
//   final bool showWeekDays;
//   final bool showHeaderButton;
//   final Widget leftButtonIcon;
//   final Widget rightButtonIcon;
//   final ScrollPhysics customGridViewPhysics;
//   final Function(DateTime) onCalendarChanged;
//   final String locale;
//   final int firstDayOfWeek;
//   final DateTime minSelectedDate;
//   final DateTime maxSelectedDate;
//   final TextStyle inactiveDaysTextStyle;
//   final TextStyle inactiveWeekendTextStyle;
//   final bool headerTitleTouchable;
//   final Function onHeaderTitlePressed;
//   final Function onLeftArrowPressed;
//   final Function onRightArrowPressed;
//   final WeekdayFormat weekDayFormat;
//   final bool staticSixWeekFormat;
//   final bool isScrollable;
//   final Axis scrollDirection;
//   final bool showOnlyCurrentMonthDate;
//   final bool pageSnapping;
//   final OnDayLongPressed onDayLongPressed;
//   final CrossAxisAlignment dayCrossAxisAlignment;
//   final MainAxisAlignment dayMainAxisAlignment;
//   final bool showIconBehindDayText;
//   final ScrollPhysics pageScrollPhysics;
//   final bool shouldShowTransform;
//
//   CalendarCarousel({
//     Key key,
//     this.viewportFraction = 1.0,
//     this.prevDaysTextStyle,
//     this.daysTextStyle,
//     this.nextDaysTextStyle,
//     this.prevMonthDayBorderColor = Colors.transparent,
//     this.thisMonthDayBorderColor = Colors.transparent,
//     this.nextMonthDayBorderColor = Colors.transparent,
//     this.dayPadding = 2.0,
//     this.height = double.infinity,
//     this.width = double.infinity,
//     this.todayTextStyle,
//     this.dayButtonColor = Colors.transparent,
//     this.todayBorderColor = Colors.red,
//     this.todayButtonColor = Colors.red,
//     this.selectedDateTime,
//     this.targetDateTime,
//     this.selectedDayTextStyle,
//     this.selectedDayBorderColor = Colors.green,
//     this.selectedDayButtonColor = Colors.green,
//     this.onDayPressed,
//     this.weekdayTextStyle,
//     this.iconColor = Colors.blueAccent,
//     this.headerTextStyle,
//     this.headerText,
//     this.weekendTextStyle,
//     this.markedDatesMap,
//     this.markedDateShowCountEvent= false,
//     this.markedDateIconBorderColor,
//     this.markedDateIconMaxShown = 2,
//     this.markedDateIconMargin = 5.0,
//     this.markedDateIconOffset = 5.0,
//     this.markedDateMoreShowTotal,
//     this.markedDateMoreCustomDecoration,
//     this.markedDateCustomShapeBorder,
//     this.markedDateCustomTextStyle,
//     this.markedDateMoreCustomTextStyle,
//     this.markedDateWidget,
//     this.headerMargin = const EdgeInsets.symmetric(vertical: 16.0),
//     this.childAspectRatio = 1.0,
//     this.weekDayMargin = const EdgeInsets.only(bottom: 4.0),
//     this.weekDayPadding = const EdgeInsets.all(0.0),
//     this.weekDayBackgroundColor = Colors.transparent,
//     this.customWeekDayBuilder,
//     this.customDayBuilder,
//     this.showWeekDays = true,
//     this.weekFormat = false,
//     this.showHeaderButton = true,
//     this.leftButtonIcon,
//     this.rightButtonIcon,
//     this.customGridViewPhysics,
//     this.onCalendarChanged,
//     this.locale = "en",
//     this.firstDayOfWeek,
//     this.minSelectedDate,
//     this.maxSelectedDate,
//     this.inactiveDaysTextStyle,
//     this.inactiveWeekendTextStyle,
//     this.headerTitleTouchable = false,
//     this.onHeaderTitlePressed,
//     this.onLeftArrowPressed,
//     this.onRightArrowPressed,
//     this.weekDayFormat = WeekdayFormat.short,
//     this.staticSixWeekFormat = false,
//     this.isScrollable = true,
//     this.scrollDirection = Axis.horizontal,
//     this.showOnlyCurrentMonthDate = false,
//     this.pageSnapping = false,
//     this.onDayLongPressed,
//     this.dayCrossAxisAlignment = CrossAxisAlignment.center,
//     this.dayMainAxisAlignment = MainAxisAlignment.center,
//     this.showIconBehindDayText = false,
//     this.pageScrollPhysics = const ScrollPhysics(),
//     this.shouldShowTransform = true,
//   }) : super(key: key);
//
//   @override
//   _CalendarState createState() => _CalendarState();
// }
//
// enum WeekdayFormat {
//   weekdays,
//   standalone,
//   short,
//   standaloneShort,
//   narrow,
//   standaloneNarrow,
// }
//
// class _CalendarState   extends State<CalendarCarousel> {
//   PageController _controller;
//   List<DateTime> _dates;
//   List<List<DateTime>> _weeks;
//   DateTime _selectedDate = DateTime.now();
//   DateTime _targetDate;
//   int _startWeekday = 0;
//   int _endWeekday = 0;
//   DateFormat _localeDate;
//   int _pageNum = 0;
//   DateTime minDate;
//   DateTime maxDate;
//
//   /// When FIRSTDAYOFWEEK is 0 in dart-intl, it represents Monday. However it is the second day in the arrays of Weekdays.
//   /// Therefore we need to add 1 modulo 7 to pick the right weekday from intl. (cf. [GlobalMaterialLocalizations])
//   int firstDayOfWeek;
//
//   /// If the setState called from this class, don't reload the selectedDate, but it should reload selected date if called from external class
//
//   @override
//   initState() {
//     super.initState();
//     initializeDateFormatting();
//
//     minDate = widget.minSelectedDate ?? DateTime(2018);
//     maxDate = widget.maxSelectedDate ??
//         DateTime(
//             DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);
//
//     if (widget.selectedDateTime != null)
//       _selectedDate = widget.selectedDateTime;
//     print("day" + _selectedDate.toString());
//     _init();
//
//     /// setup pageController
//     _controller = PageController(
//       initialPage: this._pageNum,
//       keepPage: true,
//       viewportFraction: widget.viewportFraction,
//
//       /// width percentage
//     );
//
//     _localeDate = DateFormat.yMMM(widget.locale);
//
//     if (widget.firstDayOfWeek == null)
//       firstDayOfWeek = (_localeDate.dateSymbols.FIRSTDAYOFWEEK + 1) % 7;
//     else
//       firstDayOfWeek = widget.firstDayOfWeek;
//
//     _setDate();
//   }
//
//   @override
//   void didUpdateWidget(CalendarCarousel oldWidget) {
//     if (widget.targetDateTime != null && widget.targetDateTime != _targetDate) {
//       _init();
//       _setDate(_pageNum);
//     }
//
//     super.didUpdateWidget(oldWidget);
//   }
//
//   @override
//   dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width,
//       height: widget.height,
//       child: Column(
//         children: <Widget>[
//           WeekdayRow(
//             firstDayOfWeek,
//             widget.customWeekDayBuilder,
//             showWeekdays: widget.showWeekDays,
//             weekdayFormat: widget.weekDayFormat,
//             weekdayMargin: widget.weekDayMargin,
//             weekdayPadding: widget.weekDayPadding,
//             weekdayBackgroundColor: widget.weekDayBackgroundColor,
//             weekdayTextStyle: widget.weekdayTextStyle,
//             localeDate: _localeDate,
//           ),
//           Expanded(
//               child: PageView.builder(
//                 itemCount:
//                 widget.weekFormat ? this._weeks.length : this._dates.length,
//                 physics: widget.isScrollable
//                     ? widget.pageScrollPhysics
//                     : NeverScrollableScrollPhysics(),
//                 scrollDirection: widget.scrollDirection,
//                 onPageChanged: (index) {
//                   this._setDate(index);
//                 },
//                 controller: _controller,
//                 itemBuilder: (context, index) {
//                   return widget.weekFormat ? weekBuilder(index) : builder(index);
//                 },
//                 pageSnapping: widget.pageSnapping,
//               )),
//         ],
//       ),
//     );
//   }
//
//   Widget getDefaultDayContainer(
//       bool isSelectable,
//       int index,
//       bool isSelectedDay,
//       bool isToday,
//       bool isPrevMonthDay,
//       TextStyle textStyle,
//       TextStyle defaultTextStyle,
//       bool isNextMonthDay,
//       bool isThisMonthDay,
//       DateTime now,
//       ) {
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       child: Row(
//         crossAxisAlignment: widget.dayCrossAxisAlignment,
//         mainAxisAlignment: widget.dayMainAxisAlignment,
//         children: <Widget>[
//           DefaultTextStyle(
//             style: getDefaultDayStyle(
//                 isSelectable,
//                 index,
//                 isSelectedDay,
//                 isToday,
//                 isPrevMonthDay,
//                 textStyle,
//                 defaultTextStyle,
//                 isNextMonthDay,
//                 isThisMonthDay),
//             child: Text(
//               '${now.day}',
//               semanticsLabel: now.day.toString(),
//               style: getDayStyle(
//                   isSelectable,
//                   index,
//                   isSelectedDay,
//                   isToday,
//                   isPrevMonthDay,
//                   textStyle,
//                   defaultTextStyle,
//                   isNextMonthDay,
//                   isThisMonthDay),
//               maxLines: 1,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget renderDay(
//       bool isSelectable,
//       int index,
//       bool isSelectedDay,
//       bool isToday,
//       bool isPrevMonthDay,
//       TextStyle textStyle,
//       TextStyle defaultTextStyle,
//       bool isNextMonthDay,
//       bool isThisMonthDay,
//       DateTime now,
//       ) {
//     return Container(
//
//       margin: EdgeInsets.all(widget.dayPadding),
//       child: Column(
//         children: [
//           Expanded(
//             child: Container(
//               height: 50,
//               width: 50,
//               decoration: isSelectedDay == true
//                   ? BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.black38,
//                       blurRadius: 10,
//                       offset: Offset(0, 2)),
//                 ],
//               )
//                   : BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//               ),
//               child: GestureDetector(
//                 onLongPress: () => _onDayLongPressed(now),
//                 child: FlatButton(
//                   color: isSelectedDay && widget.selectedDayButtonColor != null
//                       ? widget.selectedDayButtonColor
//                       : isToday && widget.todayButtonColor != null
//                       ? widget.todayButtonColor
//                       : widget.dayButtonColor,
//                   onPressed: () => _onDayPressed(now),
//                   padding: EdgeInsets.all(widget.dayPadding),
//                   shape: CircleBorder(
//                     side: BorderSide(
//                       color: isSelectedDay
//                           ? widget.selectedDayBorderColor
//                           : isToday && widget.todayBorderColor != null
//                           ? widget.todayBorderColor
//                           : isPrevMonthDay
//                           ? widget.prevMonthDayBorderColor
//                           : isNextMonthDay
//                           ? widget.nextMonthDayBorderColor
//                           : widget
//                           .thisMonthDayBorderColor,
//                     ),
//                   ),
//                   child: getDayContainer(
//                       isSelectable,
//                       index,
//                       isSelectedDay,
//                       isToday,
//                       isPrevMonthDay,
//                       textStyle,
//                       defaultTextStyle,
//                       isNextMonthDay,
//                       isThisMonthDay,
//                       now),
//                 ),
//               ),
//             ),
//           ),
//           widget.markedDateShowCountEvent == true ? _renderMarkedMapContainer(now):Container(),
//         ],
//       ),
//     );
//   }
//
//   AnimatedBuilder builder(int slideIndex) {
//     _startWeekday = _dates[slideIndex].weekday - firstDayOfWeek;
//     if (_startWeekday == 7) {
//       _startWeekday = 0;
//     }
//     _endWeekday =
//         DateTime(_dates[slideIndex].year, _dates[slideIndex].month + 1, 1)
//             .weekday -
//             firstDayOfWeek;
//     double screenWidth = MediaQuery.of(context).size.width;
//     int totalItemCount = widget.staticSixWeekFormat
//         ? 42
//         : DateTime(
//       _dates[slideIndex].year,
//       _dates[slideIndex].month + 1,
//       0,
//     ).day +
//         _startWeekday +
//         (7 - _endWeekday);
//     int year = _dates[slideIndex].year;
//     int month = _dates[slideIndex].month;
//
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         if (!widget.shouldShowTransform) {
//           return child;
//         }
//         double value = 1.0;
//         if (_controller.position.haveDimensions) {
//           value = _controller.page - slideIndex;
//           value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
//         }
//
//         return Center(
//           child: SizedBox(
//             height: Curves.easeOut.transform(value) * widget.height,
//             width: Curves.easeOut.transform(value) * screenWidth,
//             child: child,
//           ),
//         );
//       },
//       child: Stack(
//         children: <Widget>[
//           Positioned(
//             child: Container(
//               width: double.infinity,
//               height: double.infinity,
//               child: GridView.count(
//                 physics: widget.customGridViewPhysics,
//                 crossAxisCount: 7,
//                 childAspectRatio: 0.8,
//                 padding: EdgeInsets.zero,
//                 children: List.generate(totalItemCount,
//
//                     /// last day of month + weekday
//                         (index) {
//                       bool isToday =
//                           DateTime.now().day == index + 1 - _startWeekday &&
//                               DateTime.now().month == month &&
//                               DateTime.now().year == year;
//                       bool isSelectedDay = widget.selectedDateTime != null &&
//                           widget.selectedDateTime.year == year &&
//                           widget.selectedDateTime.month == month &&
//                           widget.selectedDateTime.day == index + 1 - _startWeekday;
//                       bool isPrevMonthDay = index < _startWeekday;
//                       bool isNextMonthDay = index >=
//                           (DateTime(year, month + 1, 0).day) + _startWeekday;
//                       bool isThisMonthDay = !isPrevMonthDay && !isNextMonthDay;
//
//                       DateTime now = DateTime(year, month, 1);
//                       TextStyle textStyle;
//                       TextStyle defaultTextStyle;
//                       if (isPrevMonthDay && !widget.showOnlyCurrentMonthDate) {
//                         now = now.subtract(Duration(days: _startWeekday - index));
//                         textStyle = widget.prevDaysTextStyle;
//                         defaultTextStyle = defaultPrevDaysTextStyle;
//                       } else if (isThisMonthDay) {
//                         now = DateTime(year, month, index + 1 - _startWeekday);
//                         textStyle = isSelectedDay
//                             ? widget.selectedDayTextStyle
//                             : isToday
//                             ? widget.todayTextStyle
//                             : widget.daysTextStyle;
//                         defaultTextStyle = isSelectedDay
//                             ? defaultSelectedDayTextStyle
//                             : isToday
//                             ? defaultTodayTextStyle
//                             : defaultDaysTextStyle;
//                       } else if (!widget.showOnlyCurrentMonthDate) {
//                         now = DateTime(year, month, index + 1 - _startWeekday);
//                         textStyle = widget.nextDaysTextStyle;
//                         defaultTextStyle = defaultNextDaysTextStyle;
//                       } else {
//                         return Container();
//                       }
//                       if (widget.markedDateCustomTextStyle != null &&
//                           widget.markedDatesMap != null &&
//                           widget.markedDatesMap.getEvents(now).length > 0) {
//                         textStyle = widget.markedDateCustomTextStyle;
//                       }
//                       bool isSelectable = true;
//                       if (minDate != null &&
//                           now.millisecondsSinceEpoch <
//                               minDate.millisecondsSinceEpoch)
//                         isSelectable = false;
//                       else if (maxDate != null &&
//                           now.millisecondsSinceEpoch >
//                               maxDate.millisecondsSinceEpoch) isSelectable = false;
//                       return renderDay(
//                           isSelectable,
//                           index,
//                           isSelectedDay,
//                           isToday,
//                           isPrevMonthDay,
//                           textStyle,
//                           defaultTextStyle,
//                           isNextMonthDay,
//                           isThisMonthDay,
//                           now);
//                     }),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   AnimatedBuilder weekBuilder(int slideIndex) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     List<DateTime> weekDays = _weeks[slideIndex];
//
//     weekDays = weekDays
//         .map((weekDay) => weekDay.add(Duration(days: firstDayOfWeek)))
//         .toList();
//
//     return AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           double value = 1.0;
//           if (_controller.position.haveDimensions) {
//             value = _controller.page - slideIndex;
//             value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
//           }
//
//           return Center(
//             child: SizedBox(
//               height: Curves.easeOut.transform(value) * widget.height,
//               width: Curves.easeOut.transform(value) * screenWidth,
//               child: child,
//             ),
//           );
//         },
//         child: Stack(
//           children: <Widget>[
//             Positioned(
//               child: Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 child: GridView.count(
//                   physics: widget.customGridViewPhysics,
//                   crossAxisCount: 7,
//                   childAspectRatio: widget.childAspectRatio,
//                   padding: EdgeInsets.zero,
//                   children: List.generate(weekDays.length, (index) {
//                     /// last day of month + weekday
//                     bool isToday = weekDays[index].day == DateTime.now().day &&
//                         weekDays[index].month == DateTime.now().month &&
//                         weekDays[index].year == DateTime.now().year;
//                     bool isSelectedDay = this._selectedDate != null &&
//                         this._selectedDate.year == weekDays[index].year &&
//                         this._selectedDate.month == weekDays[index].month &&
//                         this._selectedDate.day == weekDays[index].day;
//                     bool isPrevMonthDay =
//                         weekDays[index].month < this._targetDate.month;
//                     bool isNextMonthDay =
//                         weekDays[index].month > this._targetDate.month;
//                     bool isThisMonthDay = !isPrevMonthDay && !isNextMonthDay;
//
//                     DateTime now = DateTime(weekDays[index].year,
//                         weekDays[index].month, weekDays[index].day);
//                     TextStyle textStyle;
//                     TextStyle defaultTextStyle;
//                     if (isPrevMonthDay && !widget.showOnlyCurrentMonthDate) {
//                       textStyle = widget.prevDaysTextStyle;
//                       defaultTextStyle = defaultPrevDaysTextStyle;
//                     } else if (isThisMonthDay) {
//                       textStyle = isSelectedDay
//                           ? widget.selectedDayTextStyle
//                           : isToday
//                           ? widget.todayTextStyle
//                           : widget.daysTextStyle;
//                       defaultTextStyle = isSelectedDay
//                           ? defaultSelectedDayTextStyle
//                           : isToday
//                           ? defaultTodayTextStyle
//                           : defaultDaysTextStyle;
//                     } else if (!widget.showOnlyCurrentMonthDate) {
//                       textStyle = widget.nextDaysTextStyle;
//                       defaultTextStyle = defaultNextDaysTextStyle;
//                     } else {
//                       return Container();
//                     }
//                     bool isSelectable = true;
//                     if (minDate != null &&
//                         now.millisecondsSinceEpoch <
//                             minDate.millisecondsSinceEpoch)
//                       isSelectable = false;
//                     else if (maxDate != null &&
//                         now.millisecondsSinceEpoch >
//                             maxDate.millisecondsSinceEpoch)
//                       isSelectable = false;
//                     return renderDay(
//                         isSelectable,
//                         index,
//                         isSelectedDay,
//                         isToday,
//                         isPrevMonthDay,
//                         textStyle,
//                         defaultTextStyle,
//                         isNextMonthDay,
//                         isThisMonthDay,
//                         now);
//                   }),
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
//
//   _init() {
//     if (widget.targetDateTime != null) {
//       if (widget.targetDateTime.difference(minDate).inDays < 0) {
//         _targetDate = minDate;
//       } else if (widget.targetDateTime.difference(maxDate).inDays > 0) {
//         _targetDate = maxDate;
//       } else {
//         _targetDate = widget.targetDateTime;
//       }
//     } else {
//       _targetDate = _selectedDate;
//     }
//     if (widget.weekFormat) {
//       _pageNum = _targetDate.difference(_firstDayOfWeek(minDate)).inDays ~/ 7;
//     } else {
//       _pageNum = (_targetDate.year - minDate.year) * 12 +
//           _targetDate.month -
//           minDate.month;
//     }
//   }
//
//   List<DateTime> _getDaysInWeek([DateTime selectedDate]) {
//     if (selectedDate == null) selectedDate = new DateTime.now();
//
//     var firstDayOfCurrentWeek = _firstDayOfWeek(selectedDate);
//     var lastDayOfCurrentWeek = _lastDayOfWeek(selectedDate);
//
//     return _daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek).toList();
//   }
//
//   DateTime _firstDayOfWeek(DateTime date) {
//     var day = _createUTCMiddayDateTime(date);
//     return day.subtract(new Duration(days: date.weekday % 7));
//   }
//
//   DateTime _lastDayOfWeek(DateTime date) {
//     var day = _createUTCMiddayDateTime(date);
//     return day.add(new Duration(days: 7 - day.weekday % 7));
//   }
//
//   DateTime _createUTCMiddayDateTime(DateTime date) {
//     // Magic const: 12 is to maintain compatibility with date_utils
//     return new DateTime.utc(date.year, date.month, date.day, 12, 0, 0);
//   }
//
//   Iterable<DateTime> _daysInRange(DateTime start, DateTime end) {
//     var offset = start.timeZoneOffset;
//
//     return List<int>.generate(end.difference(start).inDays, (i) => i + 1)
//         .map((int i) {
//       var d = start.add(Duration(days: i - 1));
//
//       var timeZoneDiff = d.timeZoneOffset - offset;
//       if (timeZoneDiff.inSeconds != 0) {
//         offset = d.timeZoneOffset;
//         d = d.subtract(new Duration(seconds: timeZoneDiff.inSeconds));
//       }
//       return d;
//     });
//   }
//
//   void _onDayLongPressed(DateTime picked) {
//     if (widget.onDayLongPressed == null) return;
//     widget.onDayLongPressed(picked);
//   }
//
//   void _onDayPressed(DateTime picked) {
//     if (picked == null) return;
//     if (minDate != null &&
//         picked.millisecondsSinceEpoch < minDate.millisecondsSinceEpoch) return;
//     if (maxDate != null &&
//         picked.millisecondsSinceEpoch > maxDate.millisecondsSinceEpoch) return;
//
//     setState(() {
//       _selectedDate = picked;
//     });
//     if (widget.onDayPressed != null)
//       widget.onDayPressed(
//           picked,
//           widget.markedDatesMap != null
//               ? widget.markedDatesMap.getEvents(picked)
//               : []);
//   }
//
//   Future<Null> _selectDateFromPicker() async {
//     DateTime selected = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate ?? new DateTime.now(),
//       firstDate: minDate,
//       lastDate: maxDate,
//     );
//
//     if (selected != null) {
//       // updating selected date range based on selected week
//       setState(() {
//         _selectedDate = selected;
//       });
//       if (widget.onDayPressed != null)
//         widget.onDayPressed(
//             selected,
//             widget.markedDatesMap != null
//                 ? widget.markedDatesMap.getEvents(selected)
//                 : []);
//     }
//   }
//
//   void _setDatesAndWeeks() {
//     /// Setup default calendar format
//     List<DateTime> date = [];
//     int currentDateIndex = 0;
//     for (int _cnt = 0;
//     0 >=
//         DateTime(minDate.year, minDate.month + _cnt)
//             .difference(DateTime(maxDate.year, maxDate.month))
//             .inDays;
//     _cnt++) {
//       date.add(DateTime(minDate.year, minDate.month + _cnt, 1));
//       if (0 ==
//           date.last
//               .difference(
//               DateTime(this._targetDate.year, this._targetDate.month))
//               .inDays) {
//         currentDateIndex = _cnt;
//       }
//     }
//
//     /// Setup week-only format
//     List<List<DateTime>> week = [];
//     for (int _cnt = 0;
//     0 >=
//         minDate
//             .add(Duration(days: 7 * _cnt))
//             .difference(maxDate.add(Duration(days: 7)))
//             .inDays;
//     _cnt++) {
//       week.add(_getDaysInWeek(minDate.add(new Duration(days: 7 * _cnt))));
//     }
//
//     _startWeekday = date[currentDateIndex].weekday - firstDayOfWeek;
//     /*if (widget.showOnlyCurrentMonthDate) {
//       _startWeekday--;
//     }*/
//     if (/*widget.showOnlyCurrentMonthDate && */ _startWeekday == 7) {
//       _startWeekday = 0;
//     }
//     _endWeekday = DateTime(date[currentDateIndex].year,
//         date[currentDateIndex].month + 1, 1)
//         .weekday -
//         firstDayOfWeek;
//     this._dates = date;
//     this._weeks = week;
// //        this._selectedDate = widget.selectedDateTime != null
// //            ? widget.selectedDateTime
// //            : DateTime.now();
//   }
//
//   void _setDate([int page = -1]) {
//     if (page == -1) {
//       setState(() {
//         _setDatesAndWeeks();
//       });
//     } else {
//       if (widget.weekFormat) {
//         setState(() {
//           this._pageNum = page;
//           this._targetDate = this._weeks[page].first;
//         });
//
//         _controller.animateToPage(page,
//             duration: Duration(milliseconds: 1), curve: Threshold(0.0));
//       } else {
//         setState(() {
//           this._pageNum = page;
//           this._targetDate = this._dates[page];
//           _startWeekday = _dates[page].weekday - firstDayOfWeek;
//           _endWeekday = _lastDayOfWeek(_dates[page]).weekday - firstDayOfWeek;
//         });
//         _controller.animateToPage(page,
//             duration: Duration(milliseconds: 1), curve: Threshold(0.0));
//       }
//
//       //call callback
//       if (widget.onCalendarChanged != null) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           widget.onCalendarChanged(!widget.weekFormat
//               ? this._dates[page]
//               : this._weeks[page][firstDayOfWeek]);
//         });
//       }
//     }
//   }
//
//   Widget _renderMarkedMapContainer(DateTime now) {
//     return Container(
//       child: _renderMarkedMap(now),
//     );
//   }
//
//   Widget _renderMarkedMap(DateTime now) {
//     if (widget.markedDatesMap.getEvents(now).length > 0) {
//       return Container(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//                 height: 5,
//                 width: 5,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: MyColors.bgFloatButtonColor,
//                 )),
//             Text(
//               ' +${widget.markedDatesMap.getEvents(now).length}',
//               style:
//               TextStyle(fontSize: 14, color: MyColors.bgFloatButtonColor),
//             )
//           ],
//         ),
//       );
//     } else {
//       return Container(
//         child: Row(
//           children: [
//             Container(
//               height: 5,
//               width: 5,
//             ),
//             Text(
//               '',
//               style: TextStyle(fontSize: 14),
//             )
//           ],
//         ),
//       );
//     }
//   }
//
//   TextStyle getDefaultDayStyle(
//       bool isSelectable,
//       int index,
//       bool isSelectedDay,
//       bool isToday,
//       bool isPrevMonthDay,
//       TextStyle textStyle,
//       TextStyle defaultTextStyle,
//       bool isNextMonthDay,
//       bool isThisMonthDay,
//       ) {
//     return !isSelectable
//         ? defaultInactiveDaysTextStyle
//         : (_localeDate.dateSymbols.WEEKENDRANGE
//         .contains((index - 1 + firstDayOfWeek) % 7)) &&
//         !isSelectedDay &&
//         !isToday
//         ? (isPrevMonthDay
//         ? defaultPrevDaysTextStyle
//         : isNextMonthDay
//         ? defaultNextDaysTextStyle
//         : isSelectable
//         ? defaultWeekendTextStyle
//         : defaultInactiveWeekendTextStyle)
//         : isToday
//         ? defaultTodayTextStyle
//         : isSelectable && textStyle != null
//         ? textStyle
//         : defaultTextStyle;
//   }
//
//   TextStyle getDayStyle(
//       bool isSelectable,
//       int index,
//       bool isSelectedDay,
//       bool isToday,
//       bool isPrevMonthDay,
//       TextStyle textStyle,
//       TextStyle defaultTextStyle,
//       bool isNextMonthDay,
//       bool isThisMonthDay,
//       ) {
//     return isSelectedDay && widget.selectedDayTextStyle != null
//         ? widget.selectedDayTextStyle
//         : (_localeDate.dateSymbols.WEEKENDRANGE
//         .contains((index - 1 + firstDayOfWeek) % 7)) &&
//         !isSelectedDay &&
//         isThisMonthDay &&
//         !isToday
//         ? (isSelectable
//         ? widget.weekendTextStyle
//         : widget.inactiveWeekendTextStyle)
//         : !isSelectable
//         ? widget.inactiveDaysTextStyle
//         : isPrevMonthDay
//         ? widget.prevDaysTextStyle
//         : isNextMonthDay
//         ? widget.nextDaysTextStyle
//         : isToday
//         ? widget.todayTextStyle
//         : widget.daysTextStyle;
//   }
//
//   Widget getDayContainer(
//       bool isSelectable,
//       int index,
//       bool isSelectedDay,
//       bool isToday,
//       bool isPrevMonthDay,
//       TextStyle textStyle,
//       TextStyle defaultTextStyle,
//       bool isNextMonthDay,
//       bool isThisMonthDay,
//       DateTime now) {
//     if (widget.customDayBuilder != null) {
//       final TextStyle appTextStyle = DefaultTextStyle.of(context).style;
//       TextStyle styleForBuilder = appTextStyle.merge(getDayStyle(
//           isSelectable,
//           index,
//           isSelectedDay,
//           isToday,
//           isPrevMonthDay,
//           textStyle,
//           defaultTextStyle,
//           isNextMonthDay,
//           isThisMonthDay));
//
//       return widget.customDayBuilder(
//           isSelectable,
//           index,
//           isSelectedDay,
//           isToday,
//           isPrevMonthDay,
//           styleForBuilder,
//           isNextMonthDay,
//           isThisMonthDay,
//           now) ??
//           getDefaultDayContainer(
//               isSelectable,
//               index,
//               isSelectedDay,
//               isToday,
//               isPrevMonthDay,
//               textStyle,
//               defaultTextStyle,
//               isNextMonthDay,
//               isThisMonthDay,
//               now);
//     } else {
//       return getDefaultDayContainer(
//           isSelectable,
//           index,
//           isSelectedDay,
//           isToday,
//           isPrevMonthDay,
//           textStyle,
//           defaultTextStyle,
//           isNextMonthDay,
//           isThisMonthDay,
//           now);
//     }
//   }
// }
