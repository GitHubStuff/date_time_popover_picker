// Copyright 2021, LTMM LLC.
import 'package:flutter/material.dart';

import '../../date_time_popover_picker.dart';
import '../buttons/date_time_toggle.dart';
import 'date_picker_stack_widget.dart';
import 'date_time_preview.dart';

class DateTimePickerWidget extends StatelessWidget {
  final DateTime initialDateTime;
  final PickerCallback pickerCallback;

  const DateTimePickerWidget({
    Key? key,
    required this.initialDateTime,
    required this.pickerCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DateTimePreview(),
        DateTimeToggle(),
        DateTimePickerStackWidget(
          pickerCallback: pickerCallback,
        ),
      ],
    );
  }
}
