library date_timer_picker_widget;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_classes/source/extensions/date_time_extensions.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_manager/theme_manager.dart';

import 'source/constants.dart' as K;
import 'source/cubit/date_time_cubit.dart';
import 'source/widgets/day_widget.dart';
import 'source/widgets/picker_widget.dart';

export 'source/cubit/date_time_cubit.dart';

typedef void PickerCallback(DateTime? dateTime);

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
              return DayWidget(
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

class DateTimePickerConstants {
  DateTimePickerConstants() {
    ThemeColors captionWidget = ThemeColors(
      dark: Color(0xff7990ff),
      light: Colors.red,
    );
    ThemeColors textColors = ThemeColors(
      dark: Colors.white70,
      light: Colors.black87,
    );
    ThemeColors dateWidget = ThemeColors(
      dark: Color(0xff0047ab),
      light: Color(0xffcccccc),
    );
    ThemeColors timeWidget = ThemeColors(
      dark: Color(0xff5a77e3),
      light: Color(0xffeeeeee),
    );
    ThemeManager.defaultThemeColors(captionWidget, forKey: K.captionColors);
    ThemeManager.defaultThemeColors(textColors, forKey: K.characterColors);
    ThemeManager.defaultThemeColors(dateWidget, forKey: K.dateColors);
    ThemeManager.defaultThemeColors(timeWidget, forKey: K.timeColors);
  }
}
