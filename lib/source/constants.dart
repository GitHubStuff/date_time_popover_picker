// Copyright 2021, LTMM LLC.
import 'package:flutter/material.dart';
import 'package:theme_manager/theme_manager.dart';

const EdgeInsets padding = EdgeInsets.all(1.0);
const double fontSize = 20.0;
const pickerExtent = 38.0;
const Size yearSize = Size(100.0, pickerExtent);

TextStyle textStyle({required BuildContext context, TextStyle? textStyle}) => (textStyle ?? TextStyle()).copyWith(
      color: ThemeManager.color(characterColors, context: context),
      fontSize: fontSize,
    );

const String captionColors = 'com.icodeforyou.captionColors';
const String characterColors = 'com.icodeforyou.textColors';
const String dateColors = 'com.icodeforyou.com.dateColors';
const String timeColors = 'com.icodeforyou.com.timeColors';
