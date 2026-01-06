import 'package:targetshop/src/features/favorites/domain/favorite_products_entity.dart';

 
class FavoriteProductModel extends FavoriteProductsEntity {
    FavoriteProductModel({
    required super.id,
    required super.name,
    required super.details,
    required super.price,
    required super.image,
    required super.quantity,
    required super.categoryId,
    super.like = false,});

  factory FavoriteProductModel.fromFirestore(Map<String, dynamic> data, String id) {
 
    return FavoriteProductModel(
      id: id,
      name: data['name'] ?? '',
            categoryId: data['categoryId'] ?? '',
       details: data['details'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      image: data['image'] ?? '',
      quantity: (data['quantity'] ?? 0).toDouble(),
      like: data['like'] ?? false,
     );
  }
 
FavoriteProductModel copyWith({
  bool? like,
  double? quantity,
}) {
  return FavoriteProductModel(
    id: id,
    name: name,
    details: details,
    price: price,
    image: image,
    categoryId: categoryId,
    quantity: quantity ?? this.quantity,
    like: like ?? this.like,
  );
}

 

}
