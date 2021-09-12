import 'package:bloc/bloc.dart';
import 'package:date_timer_picker_widget/source/year/check_if_year_or_month_change_impacts_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:meta/meta.dart';

import '../../source/constants.dart' as K;

part 'date_time_state.dart';

class DateTimeCubit extends Cubit<DateTimeState> {
  DateTime dateTime;

  DateTimeCubit(this.dateTime) : super(DateTimeInitial(dateTime: dateTime));

  int _roundDays(int index, DateTime dateTime) => (index % (DateTimeExtension.daysInMonth(dateTime.month, year: dateTime.year))) + 1;

  bool get _isPM => dateTime.hour >= 12;

  int initialPickerValue(DateTimeElement element) {
    switch (element) {
      case DateTimeElement.year:
        return dateTime.year - K.baseYear;
      case DateTimeElement.month:
        return (dateTime.month - 1) + 12;
      case DateTimeElement.day:
        final dayCount = dateTime.daysInTheMonth;
        return (dateTime.day - 1) + dayCount;
      case DateTimeElement.hour:
        return ((dateTime.hour % 12) + 12);
      case DateTimeElement.minute:
        return dateTime.minute + 60;
      case DateTimeElement.second:
        return dateTime.second + 60;
      default:
        throw FlutterError('No value for element: ${element.toString()}');
    }
  }

  void setElement(DateTimeElement element, {required int toIndex}) {
    switch (element) {
      case DateTimeElement.year:
        final pickerManager = CheckIfYearOrMonthChangeImpactsDay(initialDateTime: dateTime);
        final bool dayChanged = pickerManager.year(toIndex);
        dateTime = pickerManager.dateTime;
        if (dayChanged) emit(DayChanged());
        break;
      case DateTimeElement.month:
        final pickerManager = CheckIfYearOrMonthChangeImpactsDay(initialDateTime: dateTime);
        final bool dayChanged = pickerManager.month(toIndex);
        dateTime = pickerManager.dateTime;
        if (dayChanged) emit(DayChanged());
        break;
      case DateTimeElement.day:
        dateTime = dateTime.update(element, to: _roundDays(toIndex, dateTime));
        break;
      case DateTimeElement.hour:
        final newHour = (toIndex % 12) + (_isPM ? 12 : 0);
        dateTime = dateTime.update(element, to: newHour);
        break;
      case DateTimeElement.minute:
        dateTime = dateTime.update(element, to: toIndex % 60);
        break;
      case DateTimeElement.second:
        dateTime = dateTime.update(element, to: toIndex % 60);
        break;
      default:
        throw FlutterError('No rounding for ${element.toString()}');
    }
    final date = dateTime.shortDate();
    final time = dateTime.shortTime();
    debugPrint('SET: ${element.toString()} $date $time');
  }
}
