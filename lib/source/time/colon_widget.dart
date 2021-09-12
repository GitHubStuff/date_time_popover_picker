import 'package:date_timer_picker_widget/source/cubit/date_time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:theme_manager/theme_manager.dart';

import '../constants.dart' as K;

class ColonWidget extends StatefulWidget {
  const ColonWidget({Key? key}) : super(key: key);

  _ColonWidget createState() => _ColonWidget();
}

class _ColonWidget extends ObservingStatefulWidget<ColonWidget> {
  late FixedExtentScrollController scrollController;

  @override
  void initState() {
    super.initState();
    final int firstIndex = 0;
    scrollController = FixedExtentScrollController(initialItem: firstIndex);
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = ThemeManager.themeMode.asBrightness(context: context);
    return Container(
      color: K.pickerBackgroundColor(brightness, DateTimeElement.hour),
      height: K.heightPicker,
      width: K.widthColon,
      child: Center(
        child: ListWheelScrollView.useDelegate(
          itemExtent: K.pickerExtent,
          physics: FixedExtentScrollPhysics(),
          controller: scrollController,
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, int index) {
              return K.pickerWidget(atIndex: index, forElement: null, dateTime: null);
            },
          ),
        ),
      ),
    );
  }
}
