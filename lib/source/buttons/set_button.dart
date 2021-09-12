import 'package:flutter/material.dart';

import '../constants.dart' as K;

class SetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 24.0,
        width: 48.0,
        decoration: BoxDecoration(
          color: K.defaultSetButtonBackgroundColors.of(context),
          border: Border.all(color: K.defaultSetButtonBorderColors.of(context), width: 2.0),
          borderRadius: new BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            'Set',
            style: new TextStyle(fontSize: 18.0, color: K.defaultSetButtonTextColors.of(context)),
          ),
        ),
      ),
    );
  }
}
