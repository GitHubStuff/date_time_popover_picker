// Copyright 2021, LTMM LLC.
import 'package:flutter/material.dart';
import 'package:flutter_classes/source/extensions/date_time_extensions.dart';
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

Color dateElementColor(BuildContext context, {required DateTimeElement element}) {
  switch (element) {
    case DateTimeElement.year:
    case DateTimeElement.month:
    case DateTimeElement.day:
      return Colors.green;
    case DateTimeElement.hour:
    case DateTimeElement.minute:
    case DateTimeElement.second:
    default:
      return Colors.red;
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
