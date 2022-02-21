class CaregiverRecomendationUserData {
  String name;
  String? imageURL;
  CaregiverRecomendationUserData({
    required this.name,
    required this.imageURL,
  });

  factory CaregiverRecomendationUserData.empty() {
    return CaregiverRecomendationUserData(name: '', imageURL: null);
  }
}
