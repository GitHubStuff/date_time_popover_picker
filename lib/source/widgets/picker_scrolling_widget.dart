import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';

import '/source/abstracts/picker_delegate.dart';
import '../constants.dart' as K;
import 'picker_text.dart';

class PickerScrollingWidget extends StatefulWidget {
  final PickerDelegate pickerDelegate;
  const PickerScrollingWidget({required this.pickerDelegate});
  _PickerScrollingWidget createState() => _PickerScrollingWidget();
}

class _PickerScrollingWidget extends ObservingStatefulWidget<PickerScrollingWidget> {
  @override
  Widget build(BuildContext context) {
    return _contained();
  }

  Widget _contained() {
    return Container(height: K.pickerExtent * 2.5, child: _scroll());
  }

  Widget _scroll() {
    return ListWheelScrollView.useDelegate(
      squeeze: 1.4,
      physics: FixedExtentScrollPhysics(),
      useMagnifier: false,
      magnification: 1.05,
      itemExtent: K.pickerExtent,
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (BuildContext context, int index) {
          if (index < 0 || index > widget.pickerDelegate.limit) return null;
          return PickerText(
            text: widget.pickerDelegate.text(at: index),
            size: widget.pickerDelegate.size,
          );
        },
      ),
    );
  }
}
