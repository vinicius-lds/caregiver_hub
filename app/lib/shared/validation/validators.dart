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

String? Function(String?) equalTo(String? other) {
  return (value) {
    if (value != other) {
      return 'Os valores não são iguais';
    }
    return null;
  };
}

String? requiredValue(dynamic value) {
  if (value == null || value == '') {
    return 'O campo é obrigatório';
  }
  return null;
}

String? validCPF(String? cpf) {
  // CPF must be defined
  if (cpf == null || cpf.isEmpty) {
    return 'O CPF é inválido';
  }

  cpf = cpf.replaceAll('.', '').replaceAll('-', '');

  // CPF must have 11 chars
  if (cpf.length != 11) {
    return 'O CPF é inválido';
  }

  // CPF can't be blacklisted
  if (cpfBlacklist.contains(cpf)) {
    return 'O CPF é inválido';
  }

  String numbers = cpf.substring(0, 9);
  numbers += _verifierDigit(numbers).toString();
  numbers += _verifierDigit(numbers).toString();

  if (numbers.substring(numbers.length - 2) != cpf.substring(cpf.length - 2)) {
    return 'O CPF é inválido';
  }

  return null;
}

int _verifierDigit(String cpf) {
  List<int> numbers =
      cpf.split("").map((number) => int.parse(number, radix: 10)).toList();

  int modulus = numbers.length + 1;

  List<int> multiplied = [];

  for (var i = 0; i < numbers.length; i++) {
    multiplied.add(numbers[i] * (modulus - i));
  }

  int mod = multiplied.reduce((buffer, number) => buffer + number) % 11;

  return (mod < 2 ? 0 : 11 - mod);
}
