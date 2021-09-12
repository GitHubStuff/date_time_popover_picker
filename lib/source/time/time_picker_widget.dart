import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';

import '../widgets/date_picker_stack_widget.dart';
import '../../source/constants.dart';
import '../../source/time/meridiem_colon_widget.dart';
import '../../source/widgets/picker_widget.dart';

export '../widgets/date_picker_stack_widget.dart';

class TimePickerWidget extends StatelessWidget {
  final PickerCallback pickerCallback;
  final bool includeSeconds;
  TimePickerWidget({required this.pickerCallback, this.includeSeconds = true});

  @override
  build(BuildContext context) {
    List<Widget> items = [
      PickerWidget(element: DateTimeElement.hour),
      MeridiemColonWidget(timeSeparators: TimeSeparator.colon),
      PickerWidget(element: DateTimeElement.minute),
    ];
    if (includeSeconds) {
      items.add(MeridiemColonWidget(timeSeparators: TimeSeparator.colon));
      items.add(PickerWidget(element: DateTimeElement.second));
    }
    items.add(MeridiemColonWidget(timeSeparators: TimeSeparator.meridiem));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items,
    );
  }
}
