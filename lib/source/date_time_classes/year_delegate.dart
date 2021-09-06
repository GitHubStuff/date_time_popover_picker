import 'package:date_timer_picker_widget/source/abstracts/picker_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';

import '../constants.dart' as K;

class YearDelegate extends PickerDelegate {
  YearDelegate()
      : super(
          limit: K.yearSpan,
          size: Size(K.yearColumnWidth, K.delegateExtent),
          element: DateTimeElement.year,
        );

  @override
  String text({required int at}) {
    return '${at + K.baseYear}';
  }
}
