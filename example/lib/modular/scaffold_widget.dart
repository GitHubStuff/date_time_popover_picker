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
          SizedBox(height: 30),
          DateTimePopoverPicker(
            key: UniqueKey(),
            brightness: Brightness.light,
            onWidget: Text('Select a bright date', style: TextStyle(fontSize: 28.0)),
            callback: (newDateTime) {
              Future.delayed(Duration(milliseconds: 250), () {
                setState(() {
                  _buttonText = '${newDateTime.toString()}';
                });
              });
            },
          ),
          SizedBox(height: 30),
          DateTimePopoverPicker(
            key: UniqueKey(),
            brightness: Brightness.dark,
            initalDateTime: DateTime.now().add(Duration(days: 33)),
            onWidget: Text('Select a dark date', style: TextStyle(fontSize: 28.0)),
            callback: (newDateTime) {
              Future.delayed(Duration(milliseconds: 250), () {
                setState(() {
                  _buttonText = '${newDateTime.toString()}';
                });
              });
            },
          ),
          SizedBox(height: 30),
          DateTimePopoverPicker(
            key: UniqueKey(),
            brightness: Brightness.dark,
            includeSeconds: false,
            initalDateTime: DateTime.now().add(Duration(days: 129)),
            onWidget: Text('Select secondless dark date', style: TextStyle(fontSize: 28.0)),
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
