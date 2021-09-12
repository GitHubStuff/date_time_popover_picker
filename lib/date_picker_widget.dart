library date_timer_picker_widget;

import 'package:date_timer_picker_widget/source/year/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:theme_manager/theme_manager.dart';

import 'source/constants.dart' as K;
import 'source/time/time_picker_widget.dart';

export 'source/cubit/date_time_cubit.dart';

typedef void PickerCallback(DateTime? dateTime);

class DateTimePickerWidget extends StatelessWidget {
  final PickerCallback pickerCallback;
  const DateTimePickerWidget({required this.pickerCallback});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      DatePickerWidget(pickerCallback: pickerCallback),
      TimePickerWidget(pickerCallback: pickerCallback),
    ]);
  }
}

class DateTimePickerConstants {
  DateTimePickerConstants() {
    ThemeColors captionWidget = ThemeColors(
      dark: Color(0xff7990ff),
      light: Colors.red,
    );
    ThemeColors textColors = ThemeColors(
      dark: Colors.white70,
      light: Colors.black87,
    );
    ThemeColors dateWidget = ThemeColors(
      dark: Color(0xff0047ab),
      light: Color(0xffcccccc),
    );
    ThemeColors timeWidget = ThemeColors(
      dark: Color(0xff5a77e3),
      light: Color(0xffeeeeee),
    );
    ThemeManager.defaultThemeColors(captionWidget, forKey: K.captionColors);
    ThemeManager.defaultThemeColors(textColors, forKey: K.characterColors);
    ThemeManager.defaultThemeColors(dateWidget, forKey: K.dateColors);
    ThemeManager.defaultThemeColors(timeWidget, forKey: K.timeColors);
  }
}
