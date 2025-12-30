class CategoriesModel {
  final String id;
  final String name;
  final String details;
   final String image;
 

  CategoriesModel({
    required this.id,
    required this.name,
    required this.details,
     required this.image,
  
   });

  factory CategoriesModel.fromFirestore(Map<String, dynamic> data, String id) {
    return CategoriesModel(
      id: id,
      name: data['name'] ?? '',
      details: data['details'] ?? '',
       image: data['image'] ?? '',
     );
  }
}