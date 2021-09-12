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
