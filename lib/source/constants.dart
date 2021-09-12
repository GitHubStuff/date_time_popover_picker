// Copyright 2021, LTMM LLC.
import 'package:flutter/material.dart';
import 'package:flutter_classes/source/extensions/date_time_extensions.dart';
import 'package:intl/intl.dart';
import 'package:theme_manager/theme_manager.dart';

enum Meridiem {
  am,
  pm,
}

enum TimeSeparator {
  colon,
  meridiem,
}

enum DateTimeItem {
  date,
  time,
}

const amPmDemarkHour = 12;
const colonIndex = 0;
const midnightHour = 0;
const secondsInMinute = 60;
const minutesInHour = 60;
ThemeColors defaultDateBackgroundColors = ThemeColors(
  dark: Colors.green.shade900,
  light: Colors.white70,
);
ThemeColors defaultSetButtonBackgroundColors = ThemeColors(
  dark: Colors.green.shade900,
  light: Colors.white70,
);
ThemeColors defaultTimeBackgroundColors = ThemeColors(dark: Colors.green.shade500, light: Colors.white54);

ThemeColors defaultTextBackgroundColors = ThemeColors(
  dark: Colors.yellow.shade800,
  light: Colors.black,
);

ThemeColors defaultSetButtonBorderColors = ThemeColors(
  dark: Colors.yellow.shade800,
  light: Colors.black,
);

ThemeColors defaultSetButtonTextColors = ThemeColors(
  dark: Colors.yellow.shade800,
  light: Colors.black,
);

const baseYear = 1700;
const defaultPickerElementWidth = 48.0;
const fontSize = 20.0;
const heightPicker = pickerExtent * 5.0;
const meridiemAmIndex = 0;
const meridiemPmIndex = 1;
const monthsInYear = 12;
const monthSpan = 35; // 3 x 12 months to offer wrapping scroll
const padding = EdgeInsets.all(1.0);
const pickerExtent = 28.0;
const totalPickerWidth = 206.0;
const widthColon = 5.0;
const widthMeridiem = defaultPickerElementWidth;
const yearSpan = 400;

Color pickerBackgroundColor(Brightness brightness, DateTimeElement? element) {
  if (element == null) return defaultDateBackgroundColors.bright(brightness);
  switch (element) {
    case DateTimeElement.year:
    case DateTimeElement.month:
    case DateTimeElement.day:
      return defaultDateBackgroundColors.bright(brightness);
    case DateTimeElement.hour:
    case DateTimeElement.minute:
    case DateTimeElement.second:
      return defaultTimeBackgroundColors.bright(brightness);
    default:
      throw FlutterError('Not color for element ${element.toString()}');
  }
}

Widget _textWidget(String text) => Text(text);

Widget? merdianWidget({required int atIndex}) {
  return (atIndex < 0 || atIndex > 1) ? null : _textWidget(DateTime(2000, 1, 1, atIndex == 0 ? 0 : 12).shortTime('a'));
}

Widget? pickerWidget({required int atIndex, required DateTimeElement? forElement, DateTime? dateTime}) {
  if (atIndex < 0) return null;
  if (forElement == null) {
    if (atIndex > 0) return null;
    return _textWidget(':');
  }
  late String text;
  switch (forElement) {
    case DateTimeElement.year:
      if (atIndex > yearSpan) return null;
      text = '${atIndex + baseYear}';
      break;
    case DateTimeElement.month:
      if (atIndex > monthSpan) return null;
      final int boundedMonth = (atIndex % 12) + 1;
      text = DateFormat('MMM').format(DateTime(2000, boundedMonth, 1));
      break;
    case DateTimeElement.day:
      final span = DateTimeExtension.daysInMonth(dateTime!.month, year: dateTime.year);
      if (atIndex > (span * 3) - 1) return null;
      text = ((atIndex % span) + 1).toString();
      break;
    case DateTimeElement.hour:
      if (atIndex > 35) return null;
      final span = (atIndex % 12);
      text = ((span == 0) ? 12 : span).toString();
      break;
    case DateTimeElement.minute:
    case DateTimeElement.second:
      text = (atIndex % 60).toString().padLeft(2, '0');
      break;
    default:
      throw FlutterError('No widget for ${forElement.toString()}');
  }
  return _textWidget(text);
}

double pickerWidth(DateTimeElement element) {
  switch (element) {
    case DateTimeElement.year:
    case DateTimeElement.month:
    case DateTimeElement.day:
    case DateTimeElement.hour:
    case DateTimeElement.minute:
    case DateTimeElement.second:
      return defaultPickerElementWidth;
    default:
      throw FlutterError('No widget for element: ${element.toString()}');
  }
}

const String captionColors = 'com.icodeforyou.captionColors';
const String characterColors = 'com.icodeforyou.textColors';
const String dateColors = 'com.icodeforyou.com.dateColors';
const String timeColors = 'com.icodeforyou.com.timeColors';
