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
const widthMonth = 40.0;
const widthYear = 50.0;
const yearSpan = 400;
const backgroundPickerColorDark = Colors.green;
const backgroundPickerColorLite = Colors.red;

Color pickerBackgroundColor(Brightness brightness) => brightness == Brightness.dark ? backgroundPickerColorDark : backgroundPickerColorLite;

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
    default:
      throw FlutterError('No widget for ${forElement.toString()}');
  }
}

double pickerWidth(DateTimeElement element) {
  switch (element) {
    case DateTimeElement.year:
      return 50.0;
    case DateTimeElement.month:
      return 45.0;
    case DateTimeElement.day:
      return 30.0;
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
