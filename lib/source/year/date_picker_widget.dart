// Copyright 2021, LTMM LLC.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_classes/flutter_classes.dart';

import '../../date_time_popover_picker.dart';
import '../../source/cubit/date_time_cubit.dart';
import '../../source/widgets/picker_widget.dart';

export '../widgets/date_picker_stack_widget.dart';

class DatePickerWidget extends StatelessWidget {
  final PickerCallback pickerCallback;
  DatePickerWidget({Key? key, required this.pickerCallback}) : super(key: key);

  @override
  build(BuildContext context) {
    final dateTimeCubit = DateTimeCubit.instance();
    UniqueKey dayKey = UniqueKey();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PickerWidget(element: DateTimeElement.month),
        BlocBuilder<DateTimeCubit, DateTimeState>(
            bloc: dateTimeCubit,
            builder: (context, state) {
              /// to reduce re-draw, create a new UniqueKey only if change in year/month changed the number
              /// days in the month (eg change from Nov:30 => Dec:31, or Year:2019+Mon:Feb => Year:2020+Mon:Feb {leap year})
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
