import 'package:flutter/material.dart';
import 'package:flutter_classes/source/extensions/date_time_extensions.dart';

import '../../source/constants.dart' as K;

ListWheelChildBuilderDelegate monthDelegate() {
  return ListWheelChildBuilderDelegate(builder: (context, int index) {
    if (index < 0 || index > K.monthSpan) return null;
    final month = (index % K.monthsInYear) + 1;
    final text = DateTime(2000, month, 1).monthText();
    return Text('$text');
  });
}
