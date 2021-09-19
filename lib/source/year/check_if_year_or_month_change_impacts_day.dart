// Copyright 2021, LTMM LLC.
import 'dart:math';

import 'package:flutter_classes/flutter_classes.dart';

import '../constants.dart' as K;

/// Go in/out of leap year, or days in month get changed.
class CheckIfYearOrMonthChangeImpactsDay {
  late DateTime _dateTime;
  CheckIfYearOrMonthChangeImpactsDay({required DateTime initialDateTime}) {
    /// Remove milli & micro seconds
    _dateTime = initialDateTime.round();
  }

  DateTime get dateTime => _dateTime;

  /// sets new year return True/False if the leap year effect is trigger (eg rolled from month/year to non-leap year)
  bool year(int index) {
    int adjustYear = K.baseYear + index;
    bool leapYearChange = _dateTime.month == DateTime.february && (DateTimeExtension.isLeapYear(_dateTime.year) != DateTimeExtension.isLeapYear(adjustYear));
    int daysInAdjustedMonth = DateTimeExtension.daysInMonth(_dateTime.month, year: adjustYear);
    int adjustedDay = min(daysInAdjustedMonth, _dateTime.day);
    _dateTime = _dateTime.update(DateTimeElement.day, to: adjustedDay);
    _dateTime = _dateTime.update(DateTimeElement.year, to: adjustYear);
    return leapYearChange;
  }

  /// Check if the selected month will change the value/range of the day (eg Jan has 31 days Feb has 28 or 29)
  bool month(int index) {
    final int adjustedMonth = (index % K.monthsInYear) + 1;
    final int year = _dateTime.year;
    final int daysInCurrentMonth = DateTimeExtension.daysInMonth(_dateTime.month, year: year);
    final int daysInAjustedMonth = DateTimeExtension.daysInMonth(adjustedMonth, year: year);
    _dateTime = _dateTime.update(DateTimeElement.day, to: min(_dateTime.day, daysInAjustedMonth));
    _dateTime = _dateTime.update(DateTimeElement.month, to: adjustedMonth);
    return daysInAjustedMonth != daysInCurrentMonth;
  }
}
