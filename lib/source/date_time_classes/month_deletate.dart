import 'package:date_timer_picker_widget/source/abstracts/picker_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';
import 'package:intl/intl.dart';

import '../constants.dart' as K;

class MonthDelegate extends PickerDelegate {
  final String fmt;
  MonthDelegate({this.fmt = 'MMM'})
      : super(
          limit: K.monthSpan,
          size: Size(K.monthColumnWidth, K.delegateExtent),
          element: DateTimeElement.month,
        );

  @override
  String text({required int at}) {
    int adjusted = (at % 12) + 1;
    final str = DateFormat(fmt).format(DateTime(2000, adjusted, 1));
    return str;
  }
}
