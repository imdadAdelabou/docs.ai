import 'package:intl/intl.dart';

/// Formats the date in the format 'yyyy/MM/dd'.
String formatDate(DateTime createdAt) {
  return DateFormat('yyyy/MM/dd').format(createdAt);
}
