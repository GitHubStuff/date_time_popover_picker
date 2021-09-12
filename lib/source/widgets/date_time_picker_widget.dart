import 'package:flutter/material.dart';
import 'package:theme_manager/theme_manager.dart';

import '../../date_time_popover_picker.dart';
import '../buttons/date_time_toggle.dart';
import '../constants.dart' as K;
import 'date_picker_stack_widget.dart';
import 'date_time_preview.dart';

class DateTimePickerWidget extends StatelessWidget {
  final DateTime initialDateTime;
  final bool showSeconds;
  final PickerCallback pickerCallback;

  const DateTimePickerWidget({
    Key? key,
    required this.initialDateTime,
    required this.pickerCallback,
    required this.showSeconds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DateTimePreview(),
        DateTimeToggle(),
        DateTimePickerStackWidget(
          pickerCallback: pickerCallback,
          showSeconds: showSeconds,
        ),
      ],
    );
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
