class CaregiverRecomendationFormData {
  final String? id;
  final String caregiverId;
  final String caregiverName;
  final String caregiverImageURL;
  final int? rating;
  final String? recomendation;

  const CaregiverRecomendationFormData({
    required this.id,
    required this.caregiverId,
    required this.caregiverName,
    required this.caregiverImageURL,
    required this.rating,
    required this.recomendation,
  });
}
