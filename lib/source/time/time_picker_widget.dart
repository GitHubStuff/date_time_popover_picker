import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';

import '../../date_picker_widget.dart';
import '../../source/widgets/picker_widget.dart';

export '../../date_picker_widget.dart';

class TimePickerWidget extends StatelessWidget {
  final PickerCallback pickerCallback;
  TimePickerWidget({required this.pickerCallback});

  @override
  build(BuildContext context) {
    return Row(
      children: [
        PickerWidget(
          element: DateTimeElement.hour,
        ),
        PickerWidget(
          element: DateTimeElement.minute,
        ),
        PickerWidget(
          element: DateTimeElement.second,
        ),
      ],
    );
  }
}
