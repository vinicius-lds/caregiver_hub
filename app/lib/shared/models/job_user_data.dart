class JobUserData {
  final String id;
  final String? imageURL;
  final String name;
  final String phone;
  final String email;
  const JobUserData({
    required this.id,
    required this.imageURL,
    required this.name,
    required this.phone,
    required this.email,
  });

  factory JobUserData.empty() {
    return const JobUserData(
      id: '',
      imageURL: null,
      name: '',
      phone: '',
      email: '',
    );
  }
}
