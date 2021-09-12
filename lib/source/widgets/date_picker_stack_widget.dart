import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_classes/source/extensions/date_time_extensions.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_manager/theme_manager.dart';

import '../../date_time_picker_widget.dart';
import '../constants.dart' as K;
import '../time/time_picker_widget.dart';
import '../year/date_picker_widget.dart';

typedef void PickerCallback(DateTime? dateTime);

class DateTimePickerStackWidget extends StatelessWidget {
  final PickerCallback pickerCallback;
  final bool showSeconds;
  const DateTimePickerStackWidget({required this.pickerCallback, this.showSeconds = true});

  @override
  Widget build(BuildContext context) {
    final dtc = Modular.get<DateTimeCubit>();
    Widget pickerWidget = DatePickerWidget(pickerCallback: pickerCallback);
    final Brightness brightness = ThemeManager.themeMode.asBrightness(context: context);
    Color backgroundColor = K.pickerBackgroundColor(brightness, DateTimeElement.year);
    return BlocBuilder<DateTimeCubit, DateTimeState>(
        bloc: dtc,
        builder: (context, state) {
          if (state is PickerTypeChanged) {
            switch (state.dateTimeItem) {
              case K.DateTimeItem.date:
                pickerWidget = DatePickerWidget(pickerCallback: pickerCallback);
                backgroundColor = K.pickerBackgroundColor(brightness, DateTimeElement.year);
                break;
              case K.DateTimeItem.time:
                pickerWidget = TimePickerWidget(pickerCallback: pickerCallback);
                backgroundColor = K.pickerBackgroundColor(brightness, DateTimeElement.hour);
            }
          }
          return Container(
            color: backgroundColor,
            width: K.totalPickerWidth,
            height: 144.0,
            child: Center(child: pickerWidget),
          );
        });
  }
}
