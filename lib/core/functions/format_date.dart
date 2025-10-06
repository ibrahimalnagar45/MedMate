import 'package:intl/intl.dart';

String formatDate(DateTime? date) {
  if (date == null) return 'غير محدد';
  return DateFormat('dd/MM – hh:mm a').format(date);
}
