import 'package:date_timer_picker_widget/source/year/check_if_year_or_month_change_impacts_day.dart';
import 'package:test/test.dart';

void main() {
  test('test date initial date/time is rounded to the second', () {
    DateTime testTime = DateTime(2017, 12, 13, 14, 15, 16, 17, 18);
    CheckIfYearOrMonthChangeImpactsDay pdtm = CheckIfYearOrMonthChangeImpactsDay(initialDateTime: testTime);
    expect(pdtm.dateTime.year, testTime.year);
    expect(pdtm.dateTime.month, testTime.month);
    expect(pdtm.dateTime.day, testTime.day);
    expect(pdtm.dateTime.hour, testTime.hour);
    expect(pdtm.dateTime.minute, testTime.minute);
    expect(pdtm.dateTime.second, testTime.second);
    expect(pdtm.dateTime.millisecond, 0);
    expect(pdtm.dateTime.microsecond, 0);
  });

  test('Roll out of leap year', () {
    DateTime testTime = DateTime(2004, 02, 29, 14, 15, 16, 17, 18);
    CheckIfYearOrMonthChangeImpactsDay pdtm = CheckIfYearOrMonthChangeImpactsDay(initialDateTime: testTime);
    expect(pdtm.dateTime.day, 29); //Make sure its leap day
    bool leftLeapDay = pdtm.year(2005 - 1700); //1700 base year
    expect(leftLeapDay, true);
    expect(pdtm.dateTime.day, 28);
  });

  test('Roll out of leap year but do not change day', () {
    DateTime testTime = DateTime(2004, 02, 14, 14, 15, 16, 17, 18);
    CheckIfYearOrMonthChangeImpactsDay pdtm = CheckIfYearOrMonthChangeImpactsDay(initialDateTime: testTime);
    bool leftLeapDay = pdtm.year(2005 - 1700); //1700 base year
    expect(leftLeapDay, true);
    expect(pdtm.dateTime.day, 14);
  });

  test('no change in days in month', () {
    DateTime testTime = DateTime(2004, 03, 14, 14, 15, 16, 17, 18);
    CheckIfYearOrMonthChangeImpactsDay pdtm = CheckIfYearOrMonthChangeImpactsDay(initialDateTime: testTime);
    bool leftLeapDay = pdtm.year(2005 - 1700); //1700 base year
    expect(leftLeapDay, false);
    expect(pdtm.dateTime.day, 14);
  });
  test('Jan 31 => Feb 29', () {
    DateTime testTime = DateTime(2004, 1, 31, 14, 15, 16, 17, 18);
    CheckIfYearOrMonthChangeImpactsDay pdtm = CheckIfYearOrMonthChangeImpactsDay(initialDateTime: testTime);
    bool adjustDayPicker = pdtm.month(1);
    expect(adjustDayPicker, true);
    expect(pdtm.dateTime.day, 29);
    expect(pdtm.dateTime.month, DateTime.february);
  });

  test('Feb 29 => Mar 29', () {
    DateTime testTime = DateTime(2004, 2, 29, 14, 15, 16, 17, 18);
    CheckIfYearOrMonthChangeImpactsDay pdtm = CheckIfYearOrMonthChangeImpactsDay(initialDateTime: testTime);
    bool adjustDayPicker = pdtm.month(2);
    expect(adjustDayPicker, true);
    expect(pdtm.dateTime.day, 29);
    expect(pdtm.dateTime.month, DateTime.march);
  });
}
