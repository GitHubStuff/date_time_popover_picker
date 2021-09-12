import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../date_time_popover_picker.dart';
import '../../source/cubit/date_time_cubit.dart';
import '../constants.dart' as K;
import '../time/time_picker_widget.dart';
import '../year/date_picker_widget.dart';

class DateTimePickerStackWidget extends StatelessWidget {
  final PickerCallback pickerCallback;
  final bool showSeconds;
  const DateTimePickerStackWidget({required this.pickerCallback, required this.showSeconds});

  @override
  Widget build(BuildContext context) {
    final dtc = DateTimeCubit.instance();
    dtc.showSeconds = showSeconds;
    Widget pickerWidget = DatePickerWidget(pickerCallback: pickerCallback);
    Color backgroundColor = K.defaultDateBackgroundColors.of(context);
    return BlocBuilder<DateTimeCubit, DateTimeState>(
        bloc: dtc,
        builder: (context, state) {
          if (state is PickerTypeChanged) {
            switch (state.dateTimeItem) {
              case K.DateTimeItem.date:
                pickerWidget = DatePickerWidget(pickerCallback: pickerCallback);
                backgroundColor = K.defaultDateBackgroundColors.of(context);
                break;
              case K.DateTimeItem.time:
                pickerWidget = TimePickerWidget(
                  pickerCallback: pickerCallback,
                  includeSeconds: showSeconds,
                );
                backgroundColor = K.defaultTimeBackgroundColors.of(context);
            }
          }
          return Container(
            color: backgroundColor,
            width: K.totalPopoverHeight,
            height: K.scrollWheelHeight,
            child: Center(child: pickerWidget),
          );
        });
  }
}
