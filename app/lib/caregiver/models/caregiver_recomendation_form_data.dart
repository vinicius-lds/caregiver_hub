class CaregiverRecomendationFormData {
  final String? id;
  final String caregiverId;
  final int? rating;
  final String? recomendation;

  const CaregiverRecomendationFormData({
    required this.id,
    required this.caregiverId,
    required this.rating,
    required this.recomendation,
  });

  factory CaregiverRecomendationFormData.empty() {
    return const CaregiverRecomendationFormData(
      id: null,
      caregiverId: '',
      rating: null,
      recomendation: null,
    );
  }
}
