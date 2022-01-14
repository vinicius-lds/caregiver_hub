class CaregiverRecomendation {
  final String id;
  final int rating;
  final String recomendation;
  final String caregiverId;
  final String employerId;

  const CaregiverRecomendation({
    required this.id,
    required this.rating,
    required this.recomendation,
    required this.caregiverId,
    required this.employerId,
  });
}
