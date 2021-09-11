part of 'date_time_cubit.dart';

@immutable
abstract class DateTimeState {}

class DateTimeInitial extends DateTimeState {
  final DateTime dateTime;
  DateTimeInitial({required this.dateTime});
}
