import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_manager/theme_manager.dart';

import '../../date_time_picker_widget.dart';
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
    dateTimeCubit = Modular.get<DateTimeCubit>();
    final int firstIndex = (widget.timeSeparators == K.TimeSeparator.colon) ? K.colonIndex : dateTimeCubit.initialMeridiemIndexValue();
    scrollController = FixedExtentScrollController(initialItem: firstIndex);
  }

  @override
  void afterFirstLayout(BuildContext buildContext) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        //debugPrint('Scrolling');
      });
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
    return Container(
      color: K.pickerBackgroundColor(brightness, DateTimeElement.hour),
      height: K.heightPicker,
      width: widget.timeSeparators == K.TimeSeparator.colon ? K.widthColon : K.widthMeridiem,
      child: Center(
        child: ListWheelScrollView.useDelegate(
          itemExtent: K.pickerExtent,
          physics: FixedExtentScrollPhysics(),
          controller: scrollController,
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, int index) {
              return widget.timeSeparators == K.TimeSeparator.colon ? K.pickerWidget(atIndex: index, forElement: null, dateTime: null) : K.merdianWidget(atIndex: index);
            },
          ),
        ),
      ),
    );
  }
}
