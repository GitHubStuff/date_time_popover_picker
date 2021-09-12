import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../date_time_picker_widget.dart';
import '../constants.dart' as K;
import '../time/time_picker_widget.dart';
import '../year/date_picker_widget.dart';

typedef void PickerCallback(DateTime? dateTime);

class DateTimePickerStackWidget extends StatelessWidget {
  final PickerCallback pickerCallback;
  final bool showSeconds;
  const DateTimePickerStackWidget({required this.pickerCallback, required this.showSeconds});

  @override
  Widget build(BuildContext context) {
    final dtc = Modular.get<DateTimeCubit>();
    dtc.showSeconds = showSeconds;
    Widget pickerWidget = DatePickerWidget(pickerCallback: pickerCallback);
    Color backgroundColor = defaultDateBackgroundColors.of(context);
    return BlocBuilder<DateTimeCubit, DateTimeState>(
        bloc: dtc,
        builder: (context, state) {
          if (state is PickerTypeChanged) {
            switch (state.dateTimeItem) {
              case K.DateTimeItem.date:
                pickerWidget = DatePickerWidget(pickerCallback: pickerCallback);
                backgroundColor = defaultDateBackgroundColors.of(context);
                break;
              case K.DateTimeItem.time:
                pickerWidget = TimePickerWidget(
                  pickerCallback: pickerCallback,
                  includeSeconds: showSeconds,
                );
                backgroundColor = defaultTimeBackgroundColors.of(context);
            }
          }
          return Container(
            color: backgroundColor,
            width: K.totalPickerWidth,
            height: K.scrollHeight,
            child: Center(child: pickerWidget),
          );
        });
  }
}
