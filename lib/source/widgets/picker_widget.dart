import 'package:date_timer_picker_widget/source/cubit/date_time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_manager/theme_manager.dart';

import '../constants.dart' as K;

class PickerWidget extends StatefulWidget {
  final DateTimeElement element;
  const PickerWidget({Key? key, required this.element}) : super(key: key);

  _PickerWidget createState() => _PickerWidget();
}

class _PickerWidget extends ObservingStatefulWidget<PickerWidget> {
  late FixedExtentScrollController scrollController;
  late DateTimeCubit dateTimeCubit;

  @override
  void initState() {
    super.initState();
    dateTimeCubit = Modular.get<DateTimeCubit>();
    final int firstIndex = dateTimeCubit.initialPickerValue(widget.element);
    scrollController = FixedExtentScrollController(initialItem: firstIndex);
  }

  @override
  void afterFirstLayout(BuildContext buildContext) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      scrollController.position.isScrollingNotifier.addListener(() {
        if (!scrollController.position.isScrollingNotifier.value) {
          final pos = scrollController.selectedItem;
          dateTimeCubit.setElement(widget.element, toIndex: pos);
        } else {}
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = ThemeManager.themeMode.asBrightness(context: context);
    return Container(
      color: K.pickerBackgroundColor(brightness, widget.element),
      height: K.heightPicker,
      width: K.pickerWidth(widget.element),
      child: Center(
        child: ListWheelScrollView.useDelegate(
          useMagnifier: true,
          magnification: 1.2,
          itemExtent: K.pickerExtent,
          physics: FixedExtentScrollPhysics(),
          controller: scrollController,
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, int index) {
              return K.pickerWidget(
                atIndex: index,
                forElement: widget.element,
                dateTime: dateTimeCubit.dateTime,
              );
            },
          ),
        ),
      ),
    );
  }
}
