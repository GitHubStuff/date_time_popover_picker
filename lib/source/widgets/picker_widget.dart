import 'package:date_timer_picker_widget/source/cubit/date_time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_manager/theme_manager.dart';

import '../constants.dart' as K;
import 'list_wheel.dart';

class PickerWidget extends StatefulWidget {
  final DateTimeElement element;
  const PickerWidget({required this.element});

  _PickerWidget createState() => _PickerWidget();
}

class _PickerWidget extends ObservingStatefulWidget<PickerWidget> {
  late FixedExtentScrollController scrollController;
  late DateTimeCubit dateTimeCubit;

  @override
  void afterFirstLayout(BuildContext buildContext) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        //debugPrint('Scrolling');
      });
      scrollController.position.isScrollingNotifier.addListener(() {
        if (!scrollController.position.isScrollingNotifier.value) {
          final pos = scrollController.selectedItem;
          debugPrint('POS: $pos for ${widget.element.toString()}');
          //dateTimeCubit.change(DateTimeElement.hour, to: (pos % K.noon) == K.midnight ? K.noon : (pos % K.noon));
        } else {}
      });
    });
  }

  @override
  void initState() {
    super.initState();
    dateTimeCubit = Modular.get<DateTimeCubit>();
    final int firstIndex = dateTimeCubit.initialPickerValue(widget.element);
    scrollController = FixedExtentScrollController(initialItem: firstIndex);
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = ThemeManager.themeMode.asBrightness(context: context);
    return Container(
      color: K.pickerBackgroundColor(brightness),
      height: K.heightPicker,
      width: K.pickerWidth(widget.element),
      child: ListWheel(
        listWheelChildDelegate: ListWheelChildBuilderDelegate(
          builder: (context, int index) {
            return K.pickerWidget(atIndex: index, forElement: widget.element, dateTime: dateTimeCubit.dateTime);
          },
        ),
        scrollController: scrollController,
      ),
    );
  }
}
