// Copyright 2021, LTMM LLC.
import 'package:flutter/material.dart';
import 'package:flutter_classes/source/extensions/date_time_extensions.dart';
import 'package:intl/intl.dart';
import 'package:theme_manager/theme_manager.dart';

const baseYear = 1700;
const delegateExtent = pickerExtent * 0.5;
const fontSize = 20.0;
const heightPicker = pickerExtent * 5.0;
const monthsInYear = 12;
const monthSpan = 35; // 3 x 12 months to offer wrapping scroll
const padding = EdgeInsets.all(1.0);
const pickerExtent = 28.0;
const yearSpan = 400;
const backgroundDatePickerColorDark = Colors.green;
const backgroundTimePickerColorDark = Colors.blueAccent;
const backgroundDatePickerColorLite = Colors.red;
const backgroundTimePickerColorLite = Colors.grey;

Color pickerBackgroundColor(Brightness brightness, DateTimeElement? element) {
  if (element == null) return brightness == Brightness.dark ? backgroundDatePickerColorDark : backgroundDatePickerColorLite;
  switch (element) {
    case DateTimeElement.year:
    case DateTimeElement.month:
    case DateTimeElement.day:
      return brightness == Brightness.dark ? backgroundDatePickerColorDark : backgroundDatePickerColorLite;
    case DateTimeElement.hour:
    case DateTimeElement.minute:
    case DateTimeElement.second:
      return brightness == Brightness.dark ? backgroundTimePickerColorDark : backgroundTimePickerColorLite;
    default:
      throw FlutterError('Not color for element ${element.toString()}');
  }
}

Widget? pickerWidget({required int atIndex, required DateTimeElement forElement, DateTime? dateTime}) {
  if (atIndex < 0) return null;
  switch (forElement) {
    case DateTimeElement.year:
      if (atIndex > yearSpan) return null;
      return Text('${atIndex + baseYear}');
    case DateTimeElement.month:
      if (atIndex > monthSpan) return null;
      final int boundedMonth = (atIndex % 12) + 1;
      final text = DateFormat('MMM').format(DateTime(2000, boundedMonth, 1));
      return Text(text);
    case DateTimeElement.day:
      final span = DateTimeExtension.daysInMonth(dateTime!.month, year: dateTime.year);
      if (atIndex > (span * 3) - 1) return null;
      final day = (atIndex % span) + 1;
      return Text('$day');
    case DateTimeElement.hour:
      if (atIndex > 35) return null;
      final span = (atIndex % 12);
      final hour = (span == 0) ? 12 : span;
      return Text('$hour');
    case DateTimeElement.minute:
    case DateTimeElement.second:
      final text = (atIndex % 60).toString().padLeft(1, '0');
      return Text(text);
    default:
      throw FlutterError('No widget for ${forElement.toString()}');
  }
}

double pickerWidth(DateTimeElement element) {
  switch (element) {
    case DateTimeElement.year:
      return 50.0;
    case DateTimeElement.month:
    case DateTimeElement.day:
      return 48.0;
    case DateTimeElement.hour:
    case DateTimeElement.minute:
    case DateTimeElement.second:
      return 48.0;
    default:
      throw FlutterError('No widget for element: ${element.toString()}');
  }
}

TextStyle textStyle({required BuildContext context, TextStyle? textStyle}) => (textStyle ?? TextStyle()).copyWith(
      color: ThemeManager.color(characterColors, context: context),
      fontSize: fontSize,
    );

const String captionColors = 'com.icodeforyou.captionColors';
const String characterColors = 'com.icodeforyou.textColors';
const String dateColors = 'com.icodeforyou.com.dateColors';
const String timeColors = 'com.icodeforyou.com.timeColors';
