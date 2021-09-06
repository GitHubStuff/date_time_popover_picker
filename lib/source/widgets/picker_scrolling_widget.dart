import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:theme_manager/theme_manager.dart';

import '/source/abstracts/picker_delegate.dart';
import '../constants.dart';
import '../constants.dart' as K;
import 'picker_text.dart';

class PickerScrollingWidget extends StatefulWidget {
  final PickerDelegate pickerDelegate;
  const PickerScrollingWidget({required this.pickerDelegate});
  _PickerScrollingWidget createState() => _PickerScrollingWidget();
}

class _PickerScrollingWidget extends ObservingStatefulWidget<PickerScrollingWidget> {
  @override
  void afterFirstLayout(BuildContext buildContext) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      widget.pickerDelegate.fixedExtentScrollController.position.isScrollingNotifier.addListener(() {
        if (!widget.pickerDelegate.fixedExtentScrollController.position.isScrollingNotifier.value) {
          final index = widget.pickerDelegate.fixedExtentScrollController.selectedItem;
          debugPrint('INDEX: $index');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _contained();
  }

  Widget _contained() {
    return Container(
      height: K.pickerExtent * 4.4,
      width: widget.pickerDelegate.size.width,
      child: _scroll(),
      color: ThemeManager.color(dateColors, context: context),
    );
  }

  Widget _scroll() {
    return ListWheelScrollView.useDelegate(
      controller: widget.pickerDelegate.fixedExtentScrollController,
      squeeze: 1.2,
      physics: FixedExtentScrollPhysics(),
      perspective: 0.01,
      itemExtent: K.pickerExtent,
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (BuildContext context, int index) {
          if (index < 0 || index > widget.pickerDelegate.limit) return null;
          return PickerText(
            text: widget.pickerDelegate.text(at: index),
          );
        },
      ),
    );
  }
}
