import './ai_datetime_const.dart' as dateCons;
import 'package:intl/intl.dart';

DateTime getThaiDateTime(DateTime aDateTime) {
  return DateTime(
    aDateTime.year + dateCons.kThaiYearOffset,
    aDateTime.month,
    aDateTime.day,
    aDateTime.hour,
    aDateTime.minute,
    aDateTime.second,
    aDateTime.millisecond,
    aDateTime.microsecond,
  );
}

String getFullThaiDateFormat(DateTime aDateTime) {
  int thaiYear = getThaiYear(aDateTime);
  String fullThaiDate = DateFormat('EEEE d MMMM yyyy', 'th').format(aDateTime);
  return fullThaiDate.replaceRange(fullThaiDate.length - 4, fullThaiDate.length, thaiYear.toString());
  // return DateFormat('EEEE d MMMM yyyy', 'th').format(getThaiDateTime(aDateTime));
}

String getThaiDateFormat(DateTime aDateTime) {
  return DateFormat('d MMMM yyyy', 'th').format(getThaiDateTime(aDateTime));
}

int getThaiYear(DateTime aDateTime) => aDateTime.year + dateCons.kThaiYearOffset;

int getThaiYearByGlobalYear(int aYear) => aYear + dateCons.kThaiYearOffset;

int getShortThaiYearFromDate(DateTime aDateTime) => getThaiYear(aDateTime) - 2500;

int getShortThaiYearFromYear(int aYear) => (aYear + 543) - 2500;

String safeDataAsString(dynamic aData, [String aDefaultString = '']) {
  String result = aDefaultString;
  if (aData == null)
    result = aDefaultString;
  else
    result = '${aData.toString()}';
  return result;
}

String getThaiWeekDayName(int aWeekDay) {
  return (aWeekDay >= 1 && aWeekDay <= 7) ? dateCons.kThaiWeekDayNameMap[aWeekDay] : '';
}

String getThaiWeekDayShortName(int aWeekDay) {
  return (aWeekDay >= 1 && aWeekDay <= 7) ? dateCons.kThaiWeekDayShortNameMap[aWeekDay] : '';
}

String getThaiMonthName(int aMonth) {
  return (aMonth >= 1 && aMonth <= 12) ? dateCons.kThaiMonthNameMap[aMonth] : '';
}

String getThaiMonthShortName(int aMonth) {
  return (aMonth >= 1 && aMonth <= 12) ? dateCons.kThaiMonthShortNameMap[aMonth] : '';
}
