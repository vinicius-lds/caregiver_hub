const List<String> cpfBlacklist = [
  "00000000000",
  "11111111111",
  "22222222222",
  "33333333333",
  "44444444444",
  "55555555555",
  "66666666666",
  "77777777777",
  "88888888888",
  "99999999999",
  "12345678909"
];

String? Function(dynamic) after(DateTime? other, {required String message}) {
  return (value) {
    if (value != null &&
        other != null &&
        value is DateTime &&
        value.isAfter(other)) {
      return message;
    }
    return null;
  };
}

String? Function(dynamic) atLeast(int minLength, {required String message}) {
  return (value) {
    if (value == null || value is! List || value.length < minLength) {
      return message;
    }
    return null;
  };
}

String? Function(dynamic) equalTo(dynamic other, {required String message}) {
  return (value) {
    print('value: $value; other: $other;');
    if (value != other) {
      return message;
    }
    return null;
  };
}

String? Function(dynamic) before(DateTime? other, {required String message}) {
  return (value) {
    if (value != null &&
        other != null &&
        value is DateTime &&
        value.isBefore(other)) {
      return message;
    }
    return null;
  };
}

String? Function(dynamic) requiredValue({required String message}) {
  return (value) {
    if (value == null || value == '') {
      return message;
    }
    return null;
  };
}

String? Function(dynamic) greaterThan(
  double Function() other, {
  required String message,
  double Function(String?)? doubleParser,
}) {
  return (value) {
    if (doubleParser != null && doubleParser(value) <= other()) {
      return message;
    }
    return null;
  };
}

String? Function(dynamic) lessThan(
  double Function() other, {
  required String message,
  double Function(String?)? doubleParser,
}) {
  return (value) {
    if (doubleParser != null && doubleParser(value) >= other()) {
      return message;
    }
    return null;
  };
}

String? Function(dynamic) validCPF({required String message}) {
  return (cpf) {
    // CPF must be defined
    if (cpf == null || cpf is! String || cpf.isEmpty) {
      return message;
    }

    cpf = cpf.replaceAll('.', '').replaceAll('-', '');

    // CPF must have 11 chars
    if (cpf.length != 11) {
      return message;
    }

    // CPF can't be blacklisted
    if (cpfBlacklist.contains(cpf)) {
      return message;
    }

    String numbers = cpf.substring(0, 9);
    numbers += _verifierDigit(numbers).toString();
    numbers += _verifierDigit(numbers).toString();

    if (numbers.substring(numbers.length - 2) !=
        cpf.substring(cpf.length - 2)) {
      return message;
    }

    return null;
  };
}

int _verifierDigit(String cpf) {
  List<int> numbers =
      cpf.split('').map((number) => int.parse(number, radix: 10)).toList();

  int modulus = numbers.length + 1;

  List<int> multiplied = [];

  for (var i = 0; i < numbers.length; i++) {
    multiplied.add(numbers[i] * (modulus - i));
  }

  int mod = multiplied.reduce((buffer, number) => buffer + number) % 11;

  return (mod < 2 ? 0 : 11 - mod);
}
