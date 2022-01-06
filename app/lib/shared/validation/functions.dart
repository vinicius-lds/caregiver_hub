String? Function(String?) composeValidators(
    List<String? Function(String?)> validators) {
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
