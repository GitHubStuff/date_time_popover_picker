import 'package:date_timer_picker_widget/date_picker_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'scaffold_widget.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => DateTimeCubit(DateTime(2020, 2, 29, 0, 1, 2))),
    Bind.singleton((i) => DateTimePickerConstants()),
  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => ScaffoldWidget(title: 'date_timer_picker_widget')),
  ];
}
