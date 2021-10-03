// Copyright 2021, LTMM LLC.
library date_time_popover_picker;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:popover/popover.dart';

import 'source/constants.dart' as K;
import 'source/cubit/date_time_cubit.dart';
import 'source/widgets/date_time_picker_widget.dart';

typedef void PickerCallback(DateTime dateTime);

/// This is the GATEWAY to the Date/Time Picker
class DateTimePopoverPicker extends StatefulWidget {
  final Widget onWidget;
  final DateTime? initalDateTime;
  final PickerCallback callback;
  final bool includeSeconds;
  final Brightness brightness;

  DateTimePopoverPicker({
    Key? key,
    required this.onWidget,
    required this.callback,
    this.initalDateTime,
    this.includeSeconds = true,
    this.brightness = Brightness.light,
  }) : super(key: key);

  @override
  _DateTimePopoverPicker createState() => _DateTimePopoverPicker();
}

class _DateTimePopoverPicker extends ObservingStatefulWidget<DateTimePopoverPicker> {
  @override
  void initState() {
    super.initState();
    final dateTime = widget.initalDateTime ?? DateTime.now().toLocal();
    DateTimeCubit(dateTime, widget.includeSeconds, widget.brightness);
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      bloc: DateTimeCubit.instance(),
      builder: (context, state) {
        debugPrint('STATE: ${state.toString()}');
        if (state is PickerSelectedDateTimeState) {
          widget.callback(state.dateTime);
          Navigator.of(context).pop();
        }
        return GestureDetector(
          child: widget.onWidget,
          onTap: () {
            final dtc = DateTimeCubit.instance()!;
            final dateTime = widget.initalDateTime ?? DateTime.now().toLocal();
            dtc.dateTime = dateTime;
            dtc.brightness = widget.brightness;
            showPopover(
              backgroundColor: K.defaultPreviewBackgroundColors.bright(widget.brightness),
              context: context,
              bodyBuilder: (context) => _picker(),
              onPop: () {},
              width: K.totalPopoverWidth,
              height: K.totalPopoverHeight,
              arrowHeight: K.arrowPixelHeight,
              arrowWidth: K.arrowPixelWidgth,
            );
          },
        );
      },
    );
  }

  Widget _picker() {
    final dateTime = (widget.initalDateTime ?? DateTime.now().toLocal());
    DateTimeCubit.instance()!.dateTime = dateTime;
    return DateTimePickerWidget(
      initialDateTime: dateTime,
      pickerCallback: widget.callback,
    );
  }
}
