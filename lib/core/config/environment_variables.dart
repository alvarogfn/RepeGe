class EnvironmentVariables {
  static const production = bool.fromEnvironment(
    'production',
    defaultValue: false,
  );
}
