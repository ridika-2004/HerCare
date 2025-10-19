import '../constants/app_constants.dart';

class DateFormatter {
  static String formatDate(DateTime date, String format) {
    switch (format) {
      case 'MMM dd':
        return '${_getMonthName(date.month)} ${date.day.toString().padLeft(2, '0')}';
      case 'MMMM yyyy':
        return '${_getMonthName(date.month)} ${date.year}';
      default:
        return '';
    }
  }
  
  static String _getMonthName(int month) {
    return AppConstants.months[month - 1];
  }
}