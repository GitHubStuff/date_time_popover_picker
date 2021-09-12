import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:theme_manager/theme_manager.dart';

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

  @override
  void initState() {
    super.initState();
    dateTimeCubit = DateTimeCubit.instance();
    final int firstIndex = dateTimeCubit.initialPickerValue(widget.element);
    scrollController = FixedExtentScrollController(initialItem: firstIndex);
  }

  @override
  void afterFirstLayout(BuildContext buildContext) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      debugPrint('ELEMENT ${widget.element.toString()} ${timeStamp.toString()}');
      final duration = (widget.element == DateTimeElement.day) ? Duration(milliseconds: 750) : Duration(milliseconds: 10);
      Future.delayed(
        duration,
        () {
          try {
            scrollController.position.isScrollingNotifier.addListener(() {
              debugPrint('Inside addListener');
              if (!scrollController.position.isScrollingNotifier.value) {
                final pos = scrollController.selectedItem;
                dateTimeCubit.setElement(widget.element, toIndex: pos);
              } else {}
            });
          } catch (e) {
            debugPrint('${e.toString()} ${widget.element.toString()}');
            Future.delayed(Duration(milliseconds: 250), () {
              debugPrint('RETRY... NOT A FAN');
              afterFirstLayout(buildContext);
            });
          }
        },
      );
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
