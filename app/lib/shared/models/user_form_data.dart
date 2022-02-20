class UserFormData {
  final String? id;
  final String? imageURL;
  final String name;
  final String cpf;
  final String phone;
  final String email;

  const UserFormData({
    this.id,
    this.imageURL,
    required this.name,
    required this.cpf,
    required this.phone,
    required this.email,
  });
}
