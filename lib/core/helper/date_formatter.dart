class DateFormatter {
  static const Map<int, String> _arabicMonths = {
    1: 'يناير',
    2: 'فبراير',
    3: 'مارس',
    4: 'أبريل',
    5: 'مايو',
    6: 'يونيو',
    7: 'يوليو',
    8: 'أغسطس',
    9: 'سبتمبر',
    10: 'أكتوبر',
    11: 'نوفمبر',
    12: 'ديسمبر',
  };

  static const Map<int, String> _englishMonths = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };

  /// [lang] ممكن يكون 'ar' أو 'en' أو أي نص عربي/إنجليزي
  static String format(DateTime date, String lang) {
    final isArabic = _isArabic(lang);

    final day = date.day < 10 ? '0${date.day}' : '${date.day}';
    final month = isArabic
        ? _arabicMonths[date.month]
        : _englishMonths[date.month];
    final year = date.year;

    return '$day $month $year';
  }

  static bool _isArabic(String text) {
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text) ||
        text.toLowerCase().startsWith('ar');
  }
}
