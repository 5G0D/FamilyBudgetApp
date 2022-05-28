import 'package:intl/intl.dart';

extension DateFormatUtils on DateFormat{
  static final _months = {
    1: 'Января',
    2: 'Февраля',
    3: 'Марта',
    4: 'Апреля',
    5: 'Мая',
    6: 'Июня',
    7: 'Июля',
    8: 'Августа',
    9: 'Сентября',
    10: 'Октября',
    11: 'Ноября',
    12: 'Декабря',
  };

  static String yMMMdRU(DateTime date){
    return date.day.toString() + " " + _months[date.month]! + ", " + date.year.toString();
  }
}