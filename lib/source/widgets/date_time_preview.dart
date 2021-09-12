import 'package:date_timer_picker_widget/source/buttons/set_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../date_time_picker_widget.dart';
import '../constants.dart' as K;

class DateTimePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dtc = Modular.get<DateTimeCubit>();
    UniqueKey dateKey = UniqueKey();
    UniqueKey timeKey = UniqueKey();
    TextStyle style = K.previewTextStyle(context);
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      bloc: dtc,
      builder: (context, state) {
        debugPrint('PREVIEW state: ${state.toString()}');
        if (state is DayChanged) dateKey = UniqueKey();
        if (state is PickerMeridiemChangedState) timeKey = UniqueKey();
        if (state is PickerChangedState) {
          switch (state.element) {
            case DateTimeElement.year:
            case DateTimeElement.month:
            case DateTimeElement.day:
              dateKey = UniqueKey();
              break;
            case DateTimeElement.hour:
            case DateTimeElement.minute:
            case DateTimeElement.second:
              timeKey = UniqueKey();
              break;
            default:
              throw FlutterError('No preview for ${state.element.toString()}');
          }
        }
        Widget previewTextWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dtc.dateText, style: style, key: dateKey),
            Text(dtc.timeText, style: style, key: timeKey),
          ],
        );
        return Container(
          width: K.totalPickerWidth,
          height: K.previewHeight,
          color: K.defaultPreviewBackgroundColors.of(context),
          child: Padding(
            padding: K.previewInsets,
            child: Row(
              children: [
                Expanded(child: previewTextWidget),
                SetButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}