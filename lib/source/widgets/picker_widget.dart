// Copyright 2021, LTMM LLC.
import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';

import '../../source/cubit/date_time_cubit.dart';
import '../constants.dart' as K;

class PickerWidget extends StatefulWidget {
  final DateTimeElement element;
  const PickerWidget({Key? key, required this.element}) : super(key: key);

  _PickerWidget createState() => _PickerWidget();
}

class _PickerWidget extends ObservingStatefulWidget<PickerWidget> {
  late FixedExtentScrollController scrollController;
  late DateTimeCubit dateTimeCubit;
  late ListWheelScrollView listWheelScrollView;

  @override
  void initState() {
    super.initState();
    dateTimeCubit = DateTimeCubit.instance()!;
    final int firstIndex = dateTimeCubit.initialPickerValue(widget.element);
    scrollController = FixedExtentScrollController(initialItem: firstIndex);
    listWheelScrollView = ListWheelScrollView.useDelegate(
      overAndUnderCenterOpacity: 0.5,
      useMagnifier: true,
      offAxisFraction: K.pickerOffAxisFraction(widget.element),
      magnification: K.listWheelScrollViewMagnification,
      itemExtent: K.pickerExtent,
      physics: FixedExtentScrollPhysics(),
      controller: scrollController,
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, int index) {
          return K.pickerWidget(
            brightness: dateTimeCubit.brightness,
            atIndex: index,
            forElement: widget.element,
            dateTime: dateTimeCubit.dateTime,
          );
        },
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext buildContext) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (scrollController.hasClients) {
        scrollController.position.isScrollingNotifier.addListener(() {
          if (!scrollController.position.isScrollingNotifier.value) {
            final pos = scrollController.selectedItem;
            dateTimeCubit.setElement(widget.element, toIndex: pos);
          } else {}
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = DateTimeCubit.instance()!.brightness;
    return Container(
      color: K.pickerBackgroundColor(brightness, widget.element),
      height: K.heightPicker,
      width: K.pickerWidth(widget.element),
      child: Center(
        child: listWheelScrollView,
      ),
    );
  }
}
