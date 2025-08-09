String formatDateTime(DateTime? dateTime) {
  if (dateTime == null) return '';

  final now = DateTime.now();
  final difference = now.difference(dateTime);

  // تنسيق الساعة والدقائق بصيغة 12 ساعة
  String formatTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final amPm = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $amPm';
  }

  if (difference.inDays == 0 &&
      dateTime.day == now.day &&
      dateTime.month == now.month &&
      dateTime.year == now.year) {
    // اليوم
    return formatTime(dateTime);
  } else if (difference.inDays == 1 ||
      (now.day - dateTime.day == 1 &&
          dateTime.month == now.month &&
          dateTime.year == now.year)) {
    // أمس
    return 'Yesterday ${formatTime(dateTime)}';
  } else {
    // تاريخ قديم
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(dateTime.day)}/${twoDigits(dateTime.month)}/${dateTime.year}';
  }
}
