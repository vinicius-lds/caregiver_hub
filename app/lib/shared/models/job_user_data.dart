class JobUserData {
  final String id;
  final String? imageURL;
  final String name;
  final String phone;
  const JobUserData({
    required this.id,
    required this.imageURL,
    required this.name,
    required this.phone,
  });

  factory JobUserData.empty() {
    return JobUserData(id: '', imageURL: null, name: '', phone: '');
  }
}
