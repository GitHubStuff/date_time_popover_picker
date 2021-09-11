import 'package:bloc/bloc.dart';
import 'package:date_timer_picker_widget/source/widgets/year_widget.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'date_time_state.dart';

class DateTimeCubit extends Cubit<DateTimeState> {
  DateTime? dateTime;
  final FixedExtentScrollController yearScrollController = FixedExtentScrollController();
  late final YearWidget yearWidget = YearWidget(yearScrollController);
  DateTimeCubit(this.dateTime) : super(DateTimeInitial(dateTime: dateTime ?? DateTime.now()));

  Widget setYear() {
    yearScrollController.jumpTo(47);
    return yearWidget;
  }
}
