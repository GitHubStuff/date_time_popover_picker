import 'package:date_timer_picker_widget/source/cubit/date_time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_manager/theme_manager.dart';

import '../constants.dart' as K;
import 'list_wheel.dart';

class DayWidget extends StatefulWidget {
  final DateTimeElement element;
  const DayWidget({Key? key, required this.element}) : super(key: key);

  _DayWidget createState() => _DayWidget();
}

class _DayWidget extends ObservingStatefulWidget<DayWidget> {
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
          debugPrint('POS: $pos for ${widget.element.toString()}');
          dateTimeCubit.setElement(widget.element, toIdex: pos);
        } else {}
      });
    });
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
