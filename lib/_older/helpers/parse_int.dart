int parseInt(dynamic value) {
  return int.tryParse(value.toString()) ?? 0;
}