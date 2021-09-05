import 'package:flutter/material.dart';

abstract class PickerDelegate {
  int limit;
  Size size;
  String text({required int at});
  PickerDelegate(this.limit, this.size);
}
