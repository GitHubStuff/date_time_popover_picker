import 'package:date_timer_picker_widget/source/time/colon_widget.dart';
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
        ColonWidget(),
        PickerWidget(
          element: DateTimeElement.minute,
        ),
        ColonWidget(),
        PickerWidget(
          element: DateTimeElement.second,
        ),
      ],
    );
  }
}
