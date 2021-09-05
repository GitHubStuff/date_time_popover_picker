import 'package:date_timer_picker_widget/source/abstracts/picker_delegate.dart';
import 'package:flutter/material.dart';

import '../constants.dart' as K;

class YearDelegate extends PickerDelegate {
  YearDelegate() : super(400, Size(100.0, K.pickerExtent * 0.5));

  @override
  String text({required int at}) {
    return '${at + 1700}';
  }
}
