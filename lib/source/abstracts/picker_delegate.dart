import 'package:flutter/material.dart';
import 'package:flutter_classes/flutter_classes.dart';

abstract class PickerDelegate {
  FixedExtentScrollController fixedExtentScrollController = FixedExtentScrollController();
  DateTimeElement element;
  int limit;
  Size size;
  String text({required int at});
  PickerDelegate({required this.limit, required this.size, required this.element});
}
