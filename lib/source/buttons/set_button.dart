import 'package:flutter/material.dart';

class SetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        //height: 50.0,
        width: 48.0,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          border: Border.all(color: Colors.white, width: 2.0),
          borderRadius: new BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            'Set',
            style: new TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
