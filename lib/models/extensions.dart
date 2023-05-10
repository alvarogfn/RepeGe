import 'dart:io';

extension StringExtension on String {
  String toCapitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension FileExt on File {
  String? get ext {
    return path.split('.').last;
  }
}
