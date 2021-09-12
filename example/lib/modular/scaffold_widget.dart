import 'package:date_time_popover_picker/date_time_popover_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:theme_manager/theme_manager.dart';

class ScaffoldWidget extends StatefulWidget {
  ScaffoldWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ScaffoldWidget createState() => _ScaffoldWidget();
}

class _ScaffoldWidget extends State<ScaffoldWidget> {
  String _buttonText = 'Date';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          ThemeControlWidget(),
        ],
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(AppLocalizations.of(context)!.helloWorld), //Example of localization
          Text(_buttonText),
          DateTimePopoverPicker(
            key: UniqueKey(),
            initalDateTime: DateTime.now(),
            onWidget: Text('Select a date', style: TextStyle(fontSize: 24.0)),
            callback: (newDateTime) {
              Future.delayed(Duration(milliseconds: 250), () {
                setState(() {
                  _buttonText = '${newDateTime.toString()}';
                });
              });
            },
          ),
        ],
      ),
    );
  }
}
