T getEnumByName<T extends Enum>(dynamic enumValue, String name) {
  enumValue.values.firstWhere();

  return enumValue;
}
