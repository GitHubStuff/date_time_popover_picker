// Copyright 2021, LTMM LLC.
import 'package:date_time_popover_picker/source/cubit/date_time_cubit.dart';
import 'package:flutter/material.dart';

import '../constants.dart' as K;

class SetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DateTimeCubit.instance().returnDateTime();
      },
      child: Container(
        height: K.setButtonHeight,
        width: K.setButtonWidth,
        decoration: BoxDecoration(
          color: K.defaultSetButtonBackgroundColors.of(context),
          border: Border.all(color: K.defaultSetButtonBorderColors.of(context), width: K.setButtonBorder),
          borderRadius: new BorderRadius.circular(K.setButtonRadius),
        ),
        child: Center(
          child: Text(
            K.setText,
            style: K.setButtonStyle(context),
          ),
        ),
      ),
    );
  }
}
