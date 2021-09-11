import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';

import '../../source/delegates/month_delegate.dart';
import '../constants.dart' as K;
import 'list_wheel.dart';

class MonthWidget extends StatelessWidget {
  final FixedExtentScrollController scrollController = FixedExtentScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: K.dateElementColor(context, element: DateTimeElement.month),
      height: K.heightPicker,
      width: K.widthMonth,
      child: ListWheel(
        listWheelChildDelegate: monthDelegate(),
        scrollController: scrollController,
      ),
    );
  }
}
