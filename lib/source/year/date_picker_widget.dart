import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:flutter_modular/flutter_modular.dart';

export '../../date_picker_widget.dart';
import '../../date_picker_widget.dart';
import '../../source/widgets/picker_widget.dart';

class DatePickerWidget extends StatelessWidget {
  final PickerCallback pickerCallback;
  DatePickerWidget({required this.pickerCallback});

  @override
  build(BuildContext context) {
    final dtc = Modular.get<DateTimeCubit>();
    return Row(
      children: [
        PickerWidget(
          element: DateTimeElement.month,
        ),
        BlocBuilder<DateTimeCubit, DateTimeState>(
            bloc: dtc,
            builder: (context, state) {
              return PickerWidget(
                key: UniqueKey(),
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
