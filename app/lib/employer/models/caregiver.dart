class Caregiver {
  final String id;
  final String name;
  final String imageURL;
  final String bio;
  final double? startPriceRange;
  final double? endPriceRange;
  final double rating;

  const Caregiver({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.bio,
    required this.startPriceRange,
    required this.endPriceRange,
    required this.rating,
  });
}
