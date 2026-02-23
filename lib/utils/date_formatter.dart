import 'package:intl/intl.dart';

Future<void> initializeDateFormatting() async {
  // Initialization if needed
}

String formatDate(DateTime date) {
  try {
    return DateFormat('d MMMM', 'ru_RU').format(date);
  } catch (e) {
    // Fallback if ru_RU is not available
    final monthNames = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря',
    ];
    return '${date.day} ${monthNames[date.month - 1]}';
  }
}
