import 'package:flutter/material.dart';

import '../../source/constants.dart' as K;

ListWheelChildBuilderDelegate yearDelegate() {
  return ListWheelChildBuilderDelegate(builder: (context, int index) {
    if (index < 0 || index > K.yearSpan) return null;
    return Text('${index + K.baseYear}');
  });
}
