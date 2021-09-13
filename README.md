# date_time_popover_picker

This is an example project that is a good framework for an app

- It uses flutter_bloc

## Getting Started

INSTALL:

```ymal
dependencies:
  date_time_popover_picker:
    git:
      url: https://github.com/GitHubStuff/date_time_popover_picker.git
```

IMPORT:

```dart
import 'package:date_time_popover_picker/date_time_popover_picker.dart
```

```dart
DateTimePopoverPicker(
            Key? key,
            DateTime? initalDateTime,  //if omitted value => DateTime.now().local()
            required Widget onWidget,
            required Function(DateTime) callback,  // Returns selected date/time
            bool includeSeconds,  //default: true
          );
```
