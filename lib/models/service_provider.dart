// models/service_provider.dart
class ServiceProvider {
  final String name;
  final String category;
  final String description;
  final String phone;
  final String location;
  final double rating;
  final bool isVerified;
  final String image;

  ServiceProvider({
    required this.name,
    required this.category,
    required this.description,
    required this.phone,
    required this.location,
    required this.rating,
    required this.isVerified,
    required this.image,
  });
}
