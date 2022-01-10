String? Function(dynamic) composeValidators(
  List<String? Function(dynamic)> validators,
) {
  return (value) {
    for (final validator in validators) {
      final String? result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  };
}
