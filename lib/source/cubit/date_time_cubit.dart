import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../source/year/check_if_year_or_month_change_impacts_day.dart';
import '../constants.dart' as K;

part 'date_time_state.dart';

class DateTimeCubit extends Cubit<DateTimeState> {
  static DateTimeCubit? _instance;
  DateTimeCubit._internal(DateTime dateTime) : super(DateTimeInitial(dateTime: dateTime));
  factory DateTimeCubit(DateTime initialDateTime, bool includeSeconds) {
    _instance = DateTimeCubit._internal(initialDateTime);
    _instance!._dateTime = initialDateTime.round(includeSeconds ? DateTimeElement.second : DateTimeElement.minute);
    _instance!._showSeconds = includeSeconds;
    return _instance!;
  }
  factory DateTimeCubit.instance() => _instance!;

  late DateTime _dateTime;
  late bool _showSeconds;

  DateTime get dateTime => _dateTime;
  set dateTime(DateTime newDateTime) => _dateTime = newDateTime.round(
        _showSeconds ? DateTimeElement.second : DateTimeElement.minute,
      );
  bool get showSeconds => _showSeconds;
  set showSeconds(bool newValue) {
    _showSeconds = newValue;
    _dateTime = _dateTime.round(newValue ? DateTimeElement.second : DateTimeElement.minute);
  }

  void returnDateTime() => emit(PickerSelectedDateTimeState(_dateTime));

  String get dateText => DateFormat(K.previewDateFormat).format(_dateTime);

  String get timeText => DateFormat(_showSeconds ? K.previewTimeFormat : K.previewTimeNoSeconds).format(_dateTime);

  bool get _isPM => _dateTime.hour >= K.amPmDemarkHour;

  int initialMeridiemIndexValue() => _dateTime.hour < K.amPmDemarkHour ? K.meridiemAmIndex : K.meridiemPmIndex;

  int initialPickerValue(DateTimeElement element) {
    switch (element) {
      case DateTimeElement.year:
        return _dateTime.year - K.baseYear;
      case DateTimeElement.month:
        return (_dateTime.month - 1) + K.monthsInYear; // -1 => adjust for zero offset
      case DateTimeElement.day:
        final dayCount = _dateTime.daysInTheMonth;
        return (_dateTime.day - 1) + dayCount; // -1 => adjust for zero offset
      case DateTimeElement.hour:
        return ((_dateTime.hour % K.amPmDemarkHour) + K.amPmDemarkHour);
      case DateTimeElement.minute:
        return _dateTime.minute + K.minutesInHour;
      case DateTimeElement.second:
        return _dateTime.second + K.secondsInMinute;
      default:
        throw FlutterError('No value for element: ${element.toString()}');
    }
  }

  void selectItem(K.DateTimeItem dateTimeItem) {
    emit(PickerTypeChanged(dateTimeItem: dateTimeItem));
  }

  void setElement(DateTimeElement element, {required int toIndex}) {
    switch (element) {
      case DateTimeElement.year:
        final pickerManager = CheckIfYearOrMonthChangeImpactsDay(initialDateTime: _dateTime);
        final bool dayChanged = pickerManager.year(toIndex);
        dateTime = pickerManager.dateTime;
        if (dayChanged) {
          emit(DayChanged());
          return;
        }
        break;
      case DateTimeElement.month:
        final pickerManager = CheckIfYearOrMonthChangeImpactsDay(initialDateTime: _dateTime);
        final bool dayChanged = pickerManager.month(toIndex);
        dateTime = pickerManager.dateTime;
        if (dayChanged) {
          emit(DayChanged());
          return;
        }
        break;
      case DateTimeElement.day:
        dateTime = _dateTime.update(element, to: _roundDays(toIndex, _dateTime));
        break;
      case DateTimeElement.hour:
        final newHour = (toIndex % K.amPmDemarkHour) + (_isPM ? K.amPmDemarkHour : K.midnightHour);
        dateTime = _dateTime.update(element, to: newHour);
        break;
      case DateTimeElement.minute:
        dateTime = _dateTime.update(element, to: toIndex % K.minutesInHour);
        break;
      case DateTimeElement.second:
        dateTime = _dateTime.update(element, to: toIndex % K.secondsInMinute);
        break;
      default:
        throw FlutterError('No rounding for ${element.toString()}');
    }
    emit(PickerChangedState(element));
  }

  void setMeridiem({required K.TimeSeparator seperatorType, required int index}) {
    if (seperatorType == K.TimeSeparator.colon) return;
    if (index == K.meridiemAmIndex && _dateTime.hour < K.amPmDemarkHour) return;
    if (index == K.meridiemPmIndex && _dateTime.hour >= K.amPmDemarkHour) return;
    int delta = (index == K.meridiemAmIndex) ? -K.amPmDemarkHour : K.amPmDemarkHour;
    dateTime = _dateTime.update(DateTimeElement.hour, to: _dateTime.hour + delta);
    emit(PickerMeridiemChangedState());
  }

  int _roundDays(int index, DateTime dateTime) => (index % (DateTimeExtension.daysInMonth(dateTime.month, year: dateTime.year))) + 1;
}
