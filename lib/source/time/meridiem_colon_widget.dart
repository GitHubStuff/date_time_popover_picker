// Copyright 2021, LTMM LLC.
import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:theme_manager/theme_manager.dart';

import '../../source/cubit/date_time_cubit.dart';
import '../constants.dart' as K;

class MeridiemColonWidget extends StatefulWidget {
  final K.TimeSeparator timeSeparators;
  const MeridiemColonWidget({Key? key, required this.timeSeparators}) : super(key: key);

  _MeridiemColonWidget createState() => _MeridiemColonWidget();
}

class _MeridiemColonWidget extends ObservingStatefulWidget<MeridiemColonWidget> {
  late FixedExtentScrollController scrollController;
  late DateTimeCubit dateTimeCubit;

  @override
  void initState() {
    super.initState();
    dateTimeCubit = DateTimeCubit.instance()!;
    final int firstIndex = (widget.timeSeparators == K.TimeSeparator.colon) ? K.colonIndex : dateTimeCubit.initialMeridiemIndexValue();
    scrollController = FixedExtentScrollController(initialItem: firstIndex);
  }

  @override
  void afterFirstLayout(BuildContext buildContext) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {});
      scrollController.position.isScrollingNotifier.addListener(() {
        if (!scrollController.position.isScrollingNotifier.value) {
          final pos = scrollController.selectedItem;
          dateTimeCubit.setMeridiem(seperatorType: widget.timeSeparators, index: pos);
        } else {}
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = ThemeManager.themeMode.asBrightness(context: context);
    bool isSeperatorAColon = widget.timeSeparators == K.TimeSeparator.colon;
    final offAxisFraction = isSeperatorAColon ? 0.0 : K.pickerAxisFractionRight;
    return Container(
      color: K.pickerBackgroundColor(brightness, DateTimeElement.hour),
      height: K.heightPicker,
      width: isSeperatorAColon ? K.widthColon : K.widthMeridiem,
      child: Center(
        child: ListWheelScrollView.useDelegate(
          offAxisFraction: offAxisFraction,
          itemExtent: K.pickerExtent,
          physics: FixedExtentScrollPhysics(),
          controller: scrollController,
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, int index) {
              return widget.timeSeparators == K.TimeSeparator.colon
                  ? K.pickerWidget(context: context, atIndex: index, forElement: null, dateTime: null)
                  : K.merdianWidget(context: context, atIndex: index);
            },
          ),
        ),
      ),
    );
  }
}
