import 'dart:io';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension FileExt on File {
  String? get ext {
    return path.split('.').last;
  }
}
