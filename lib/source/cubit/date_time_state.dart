part of 'date_time_cubit.dart';

@immutable
abstract class DateTimeState {}

class DateTimeInitial extends DateTimeState {
  final DateTime dateTime;
  DateTimeInitial({required this.dateTime});
}

class DayChanged extends DateTimeState {}

class PickerTypeChanged extends DateTimeState {
  final K.DateTimeItem dateTimeItem;
  PickerTypeChanged({required this.dateTimeItem});
}

class PickerChangedState extends DateTimeState {
  final DateTimeElement element;
  PickerChangedState(this.element);
}

class PickerMeridiemChangedState extends DateTimeState {}

class PickerSelectedDateTimeState extends DateTimeState {
  final DateTime dateTime;
  PickerSelectedDateTimeState(this.dateTime);
}
