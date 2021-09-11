import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:meta/meta.dart';

import '../../source/constants.dart' as K;

part 'date_time_state.dart';

class DateTimeCubit extends Cubit<DateTimeState> {
  DateTime dateTime;

  DateTimeCubit(this.dateTime) : super(DateTimeInitial(dateTime: dateTime));

  int initialPickerValue(DateTimeElement element) {
    switch (element) {
      case DateTimeElement.year:
        return dateTime.year - K.baseYear;
      case DateTimeElement.month:
        return (dateTime.month - 1) + 12;
      case DateTimeElement.day:
        return (dateTime.day - 1);
      default:
        throw FlutterError('No value for element: ${element.toString()}');
    }
  }
}
