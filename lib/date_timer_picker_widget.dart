library date_timer_picker_widget;

import 'package:date_timer_picker_widget/source/date_time_classes/year_delegate.dart';
import 'package:date_timer_picker_widget/source/widgets/picker_scrolling_widget.dart';
import 'package:flutter/material.dart';
import 'package:theme_manager/theme_manager.dart';

import 'source/constants.dart' as K;

export 'source/widgets/picker_text.dart';

typedef void PickerCallback(DateTime? dateTime);

class DateTimePickerWidget extends StatelessWidget {
  final PickerCallback pickerCallback;
  const DateTimePickerWidget({required this.pickerCallback});

  @override
  build(BuildContext context) {
    return PickerScrollingWidget(pickerDelegate: YearDelegate());
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
