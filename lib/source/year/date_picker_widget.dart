import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_classes/flutter_classes.dart';

import '../../date_time_popover_picker.dart';
import '../../source/cubit/date_time_cubit.dart';
import '../../source/widgets/picker_widget.dart';

export '../widgets/date_picker_stack_widget.dart';

class DatePickerWidget extends StatelessWidget {
  final PickerCallback pickerCallback;
  DatePickerWidget({required this.pickerCallback});

  @override
  build(BuildContext context) {
    final dtc = DateTimeCubit.instance();
    UniqueKey dayKey = UniqueKey();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PickerWidget(
          element: DateTimeElement.month,
        ),
        BlocBuilder<DateTimeCubit, DateTimeState>(
            bloc: dtc,
            builder: (context, state) {
              if (state is DayChanged) dayKey = UniqueKey();
              return PickerWidget(
                key: dayKey,
                element: DateTimeElement.day,
              );
            }),
        PickerWidget(
          element: DateTimeElement.year,
        ),
      ],
    );
  }
}
