import 'package:flutter/material.dart';
import 'package:flutter_classes/source/extensions/date_time_extensions.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_manager/theme_manager.dart';

import '../../date_time_picker_widget.dart';

class DateTimeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Brightness brightness = ThemeManager.themeMode.asBrightness(context: context);
    final Color dateColor = pickerBackgroundColor(brightness, DateTimeElement.year);
    final Color timeColor = pickerBackgroundColor(brightness, DateTimeElement.hour);
    return Container(
      width: 206.0,
      height: 36.0,
      color: Colors.purple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _dateButton(dateColor),
          _timeButton(timeColor),
        ],
      ),
    );
  }

  Widget _text(String text) => Text(text);

  Widget _dateButton(Color color) => Expanded(
        child: ElevatedButton(
          onPressed: () => Modular.get<DateTimeCubit>().selectItem(DateTimeItem.date),
          style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
          ),
          child: _text('Date'),
        ),
      );
  Widget _timeButton(Color color) => Expanded(
        child: ElevatedButton(
          onPressed: () => Modular.get<DateTimeCubit>().selectItem(DateTimeItem.time),
          style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
          ),
          child: _text('Time'),
        ),
      );
}
