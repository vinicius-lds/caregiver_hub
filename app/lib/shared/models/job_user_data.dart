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

  factory JobUserData.fromDynamicMap(Map<dynamic, dynamic> data) {
    return JobUserData(
      id: data['id'],
      imageURL: data['imageURL'],
      name: data['name'],
      phone: data['phone'],
      email: data['email'],
    );
  }
}
