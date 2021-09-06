// Copyright 2021, LTMM LLC.
import 'package:flutter/material.dart';
import 'package:theme_manager/theme_manager.dart';

const delegateExtent = pickerExtent * 0.5;
const fontSize = 20.0;
const baseYear = 1700;
const yearSpan = 400;
const padding = EdgeInsets.all(1.0);
const pickerExtent = 28.0;
const yearColumnWidth = 75.0;
const yearSize = Size(100.0, pickerExtent);
const monthSpan = 35; // 3 x 12 months to offer wrapping scroll
const monthColumnWidth = 50.0;

TextStyle textStyle({required BuildContext context, TextStyle? textStyle}) => (textStyle ?? TextStyle()).copyWith(
      color: ThemeManager.color(characterColors, context: context),
      fontSize: fontSize,
    );

const String captionColors = 'com.icodeforyou.captionColors';
const String characterColors = 'com.icodeforyou.textColors';
const String dateColors = 'com.icodeforyou.com.dateColors';
const String timeColors = 'com.icodeforyou.com.timeColors';
