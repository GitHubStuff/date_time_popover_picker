import 'dart:math';

import 'package:flutter_classes/flutter_classes.dart';

const int _BaseYear = 1700;

class PickerDateTimeManager {
  late DateTime _dateTime;
  PickerDateTimeManager({required DateTime initialDateTime}) {
    _dateTime = initialDateTime.round(); /// Remove milli & micro seconds
  }

  DateTime get dateTime => _dateTime;

  /// sets new year return True/False if the leap year effect is trigger (eg rolled from month/year to non-leap year)
  bool year(int index) {
    int adjustYear = _BaseYear + index;
    bool leapYearChange = _dateTime.month == DateTime.february && (DateTimeExtension.isLeapYear(_dateTime.year) != DateTimeExtension.isLeapYear(adjustYear));
    int daysInAdjustedMonth = DateTimeExtension.daysInMonth(_dateTime.month, year: adjustYear);
    int adjustedDay = min(daysInAdjustedMonth, _dateTime.day);
    _dateTime = _dateTime.update(DateTimeElement.day, to: adjustedDay);
    _dateTime = _dateTime.update(DateTimeElement.year, to: adjustYear);
    return leapYearChange;
  }

  bool month(int index) {
    final int adjustedMonth = (index % 12) + 1;
    final int year = _dateTime.year;
    final int daysInCurrentMonth = DateTimeExtension.daysInMonth(_dateTime.month, year: year);
    final int daysInAjustedMonth = DateTimeExtension.daysInMonth(adjustedMonth, year: year);
    _dateTime = _dateTime.update(DateTimeElement.day, to: min(_dateTime.day, daysInAjustedMonth));
    _dateTime = _dateTime.update(DateTimeElement.month, to: adjustedMonth);
    return daysInAjustedMonth != daysInCurrentMonth;
  }
}
