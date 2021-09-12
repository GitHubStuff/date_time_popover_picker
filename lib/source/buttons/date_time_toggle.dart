import 'package:flutter/material.dart';
import 'package:flutter_classes/source/extensions/date_time_extensions.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_manager/theme_manager.dart';

import '../../date_time_picker_widget.dart';
import '../constants.dart' as K;

class DateTimeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Brightness brightness = ThemeManager.themeMode.asBrightness(context: context);
    final Color dateColor = K.pickerBackgroundColor(brightness, DateTimeElement.year);
    final Color timeColor = K.pickerBackgroundColor(brightness, DateTimeElement.hour);
    final Color textColor = K.defaultTextBackgroundColors.of(context);
    return Container(
      width: 206.0,
      height: 36.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _dateButton(dateColor, textColor),
          _timeButton(timeColor, textColor),
        ],
      ),
    );
  }

  Widget _text(String text, Color textColor) => Text(text, style: TextStyle(color: textColor));

  Widget _dateButton(Color color, Color textColor) => Expanded(
        child: ElevatedButton(
          onPressed: () => Modular.get<DateTimeCubit>().selectItem(DateTimeItem.date),
          style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
          ),
          child: _text('Date', textColor),
        ),
      );
  Widget _timeButton(Color color, Color textColor) => Expanded(
        child: ElevatedButton(
          onPressed: () => Modular.get<DateTimeCubit>().selectItem(DateTimeItem.time),
          style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
          ),
          child: _text('Time', textColor),
        ),
      );
}
