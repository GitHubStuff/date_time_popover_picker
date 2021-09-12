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
  factory DateTimeCubit(DateTime initialDateTime) {
    _instance = DateTimeCubit._internal(initialDateTime);
    _instance!.dateTime = initialDateTime;
    return _instance!;
  }
  factory DateTimeCubit.instance() => _instance!;

  late DateTime dateTime;
  bool _showSeconds = true;

  // DateTimeCubit(DateTime startingDateTime) : super(DateTimeInitial(dateTime: startingDateTime)) {
  //   dateTime = startingDateTime.round(_showSeconds ? DateTimeElement.second : DateTimeElement.minute);
  // }
  void returnDateTime() => emit(PickerSelectedDateTimeState(dateTime));

  String get dateText => DateFormat(K.previewDateFormat).format(dateTime);

  bool get showSeconds => _showSeconds;
  set showSeconds(bool value) {
    _showSeconds = value;
    if (!value) dateTime = dateTime.round(DateTimeElement.minute);
  }

  String get timeText => DateFormat(_showSeconds ? K.previewTimeFormat : K.previewTimeNoSeconds).format(dateTime);

  bool get _isPM => dateTime.hour >= K.amPmDemarkHour;

  int initialMeridiemIndexValue() => dateTime.hour < K.amPmDemarkHour ? K.meridiemAmIndex : K.meridiemPmIndex;

  int initialPickerValue(DateTimeElement element) {
    switch (element) {
      case DateTimeElement.year:
        return dateTime.year - K.baseYear;
      case DateTimeElement.month:
        return (dateTime.month - 1) + K.monthsInYear;
      case DateTimeElement.day:
        final dayCount = dateTime.daysInTheMonth;
        return (dateTime.day - 1) + dayCount;
      case DateTimeElement.hour:
        return ((dateTime.hour % K.amPmDemarkHour) + K.amPmDemarkHour);
      case DateTimeElement.minute:
        return dateTime.minute + K.minutesInHour;
      case DateTimeElement.second:
        return dateTime.second + K.secondsInMinute;
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
        final pickerManager = CheckIfYearOrMonthChangeImpactsDay(initialDateTime: dateTime);
        final bool dayChanged = pickerManager.year(toIndex);
        dateTime = pickerManager.dateTime;
        if (dayChanged) {
          emit(DayChanged());
          return;
        }
        break;
      case DateTimeElement.month:
        final pickerManager = CheckIfYearOrMonthChangeImpactsDay(initialDateTime: dateTime);
        final bool dayChanged = pickerManager.month(toIndex);
        dateTime = pickerManager.dateTime;
        if (dayChanged) {
          emit(DayChanged());
          return;
        }
        break;
      case DateTimeElement.day:
        dateTime = dateTime.update(element, to: _roundDays(toIndex, dateTime));
        break;
      case DateTimeElement.hour:
        final newHour = (toIndex % K.amPmDemarkHour) + (_isPM ? K.amPmDemarkHour : K.midnightHour);
        dateTime = dateTime.update(element, to: newHour);
        break;
      case DateTimeElement.minute:
        dateTime = dateTime.update(element, to: toIndex % K.minutesInHour);
        break;
      case DateTimeElement.second:
        dateTime = dateTime.update(element, to: toIndex % K.secondsInMinute);
        break;
      default:
        throw FlutterError('No rounding for ${element.toString()}');
    }
    final date = dateTime.shortDate();
    final time = dateTime.shortTime('h:mm:ss a');
    debugPrint('SET: ${element.toString()} $date $time');
    emit(PickerChangedState(element));
  }

  void setMeridiem({required K.TimeSeparator seperatorType, required int index}) {
    if (seperatorType == K.TimeSeparator.colon) return;
    if (index == K.meridiemAmIndex && dateTime.hour < K.amPmDemarkHour) return;
    if (index == K.meridiemPmIndex && dateTime.hour >= K.amPmDemarkHour) return;
    int delta = (index == K.meridiemAmIndex) ? -K.amPmDemarkHour : K.amPmDemarkHour;
    dateTime = dateTime.update(DateTimeElement.hour, to: dateTime.hour + delta);
    final date = dateTime.shortDate();
    final time = dateTime.shortTime('h:mm:ss a');
    debugPrint('SET: Meridiem $date $time');
    emit(PickerMeridiemChangedState());
  }

  int _roundDays(int index, DateTime dateTime) => (index % (DateTimeExtension.daysInMonth(dateTime.month, year: dateTime.year))) + 1;
}
