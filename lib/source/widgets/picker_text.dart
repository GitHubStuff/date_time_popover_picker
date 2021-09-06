// Copyright 2021, LTMM LLC.
import 'package:flutter/material.dart';

import '../constants.dart' as K;

/// Widget that holds the text in view row
class PickerText extends StatelessWidget {
  final String text;

  PickerText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: K.textStyle(context: context),
    );
  }
}
