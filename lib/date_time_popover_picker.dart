library date_time_popover_picker;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:popover/popover.dart';

import 'source/constants.dart' as K;
import 'source/cubit/date_time_cubit.dart';
import 'source/widgets/date_time_picker_widget.dart';

typedef void PickerCallback(DateTime dateTime);

class DateTimePopoverPicker extends StatefulWidget {
  final Widget onWidget;
  final DateTime initalDateTime;
  final PickerCallback callback;
  final bool includeSeconds;

  DateTimePopoverPicker({
    Key? key,
    required this.onWidget,
    required this.callback,
    required this.initalDateTime,
    this.includeSeconds = true,
  }) : super(key: key);

  @override
  _DateTimePopoverPicker createState() => _DateTimePopoverPicker();
}

class _DateTimePopoverPicker extends ObservingStatefulWidget<DateTimePopoverPicker> {
  @override
  void initState() {
    super.initState();
    DateTimeCubit(widget.initalDateTime.round(widget.includeSeconds ? DateTimeElement.second : DateTimeElement.minute));
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateTimeCubit, DateTimeState>(
      bloc: DateTimeCubit.instance(),
      builder: (context, state) {
        if (state is PickerSelectedDateTimeState) {
          widget.callback(state.dateTime);
          Navigator.of(context).pop();
        }
        return GestureDetector(
          child: widget.onWidget,
          onTap: () {
            showPopover(
              backgroundColor: Colors.lightGreen,
              context: context,
              bodyBuilder: (context) => _picker(),
              onPop: () {},
              width: K.totalPopoverWidth,
              height: K.totalPopoverHeight,
              arrowHeight: 7.5,
              arrowWidth: 15.0,
            );
          },
        );
      },
    );
  }

  Widget _picker() {
    return DateTimePickerWidget(
      initialDateTime: widget.initalDateTime,
      showSeconds: widget.includeSeconds,
      pickerCallback: widget.callback,
    );
  }
}
