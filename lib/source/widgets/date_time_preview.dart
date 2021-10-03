// Copyright 2021, LTMM LLC.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_classes/flutter_classes.dart';

import '../../source/buttons/set_button.dart';
import '../../source/cubit/date_time_cubit.dart';
import '../constants.dart' as K;

class DateTimePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dtc = DateTimeCubit.instance()!;
    UniqueKey dateKey = UniqueKey();
    UniqueKey timeKey = UniqueKey();
    TextStyle style = K.previewTextStyle(dtc.brightness);
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      bloc: dtc,
      builder: (context, state) {
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
          width: K.totalPopoverHeight,
          height: K.previewHeight,
          color: K.defaultPreviewBackgroundColors.bright(dtc.brightness),
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
