// Copyright 2021, LTMM LLC.
import 'package:flutter/material.dart';

import '../constants.dart' as K;

/// Widget that holds the text in view row
class PickerText extends StatelessWidget {
  final String text;
  final Size size;

  PickerText({Key? key, required this.text, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      child: Center(
        child: Text(
          '$text',
          style: K.textStyle(context: context),
        ),
      ),
    );
  }
}
