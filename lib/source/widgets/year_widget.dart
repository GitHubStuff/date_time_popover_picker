import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';

import '../constants.dart' as K;
import 'list_wheel.dart';

class YearWidget extends StatelessWidget {
  final FixedExtentScrollController controller;
  YearWidget(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: K.dateElementColor(context, element: DateTimeElement.year),
      height: K.heightPicker,
      width: K.widthYear,
      child: ListWheel(
        listWheelChildDelegate: ListWheelChildBuilderDelegate(builder: (context, int index) {
          if (index < 0 || index > K.yearSpan) return null;
          return Text('${index + K.baseYear}');
        }),
        scrollController: controller,
      ),
    );
  }
}
