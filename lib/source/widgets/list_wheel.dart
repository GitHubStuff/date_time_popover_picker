import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../source/constants.dart' as K;

class ListWheel extends StatelessWidget {
  final ListWheelChildDelegate listWheelChildDelegate;
  final ScrollController scrollController;

  ListWheel({required this.listWheelChildDelegate, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      itemExtent: K.pickerExtent,
      childDelegate: listWheelChildDelegate,
      physics: FixedExtentScrollPhysics(),
      controller: scrollController,
    );
  }
}
