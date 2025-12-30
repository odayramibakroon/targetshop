import '../../domain/entities/product_entity.dart';

class ProductsModel extends Product {
    ProductsModel({
    required super.id,
    required super.name,
    required super.details,
    required super.price,
    required super.image,
    required super.quantity,
    required super.categoryId,
    super.like = false,});

  factory ProductsModel.fromFirestore(Map<String, dynamic> data, String id) {
 
    return ProductsModel(
      id: id,
      name: data['name'] ?? '',
            categoryId: data['categoryId'] ?? '5sBFtA7sGvH2psllYP8Z',
       details: data['details'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      image: data['image'] ?? '',
      quantity: (data['quantity'] ?? 0).toDouble(),
      like: data['like'] ?? false,
     );
  }

    factory ProductsModel.fromFirestorecategoryId(Map<String, dynamic> data, String id  , {required String categoryId,}) {
 
    return ProductsModel(
      id: id,
      name: data['name'] ?? '',
      categoryId: data[categoryId]  ,
      details: data['details'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      image: data['image'] ?? '',
      quantity: (data['quantity'] ?? 0).toDouble(),
      like: data['like'] ?? false,
     );
  }

}
