import 'package:bloc/bloc.dart';
import 'package:date_timer_picker_widget/source/picker_date_time_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:meta/meta.dart';

import '../../source/constants.dart' as K;

part 'date_time_state.dart';

class DateTimeCubit extends Cubit<DateTimeState> {
  DateTime dateTime;

  DateTimeCubit(this.dateTime) : super(DateTimeInitial(dateTime: dateTime));

  int _roundDays(int index, DateTime dateTime) => (index % (DateTimeExtension.daysInMonth(dateTime.month, year: dateTime.year))) + 1;

  int initialPickerValue(DateTimeElement element) {
    switch (element) {
      case DateTimeElement.year:
        return dateTime.year - K.baseYear;
      case DateTimeElement.month:
        return (dateTime.month - 1) + 12;
      case DateTimeElement.day:
        final dayCount = dateTime.daysInTheMonth;
        return (dateTime.day - 1) + dayCount;
      default:
        throw FlutterError('No value for element: ${element.toString()}');
    }
  }

  void setElement(DateTimeElement element, {required int toIdex}) {
    switch (element) {
      case DateTimeElement.year:
        final pickerManager = PickerDateTimeManager(initialDateTime: dateTime);
        final bool dayChanged = pickerManager.year(toIdex);
        dateTime = pickerManager.dateTime;
        if (dayChanged) emit(DayChanged());
        break;
      case DateTimeElement.month:
        final pickerManager = PickerDateTimeManager(initialDateTime: dateTime);
        final bool dayChanged = pickerManager.month(toIdex);
        dateTime = pickerManager.dateTime;
        if (dayChanged) emit(DayChanged());
        break;
      case DateTimeElement.day:
        dateTime = dateTime.update(element, to: _roundDays(toIdex, dateTime));
        break;
      default:
        throw FlutterError('No rounding for ${element.toString()}');
    }
    final date = dateTime.shortDate();
    final time = dateTime.shortTime();
    debugPrint('SET: ${element.toString()} $date $time');
  }
}
