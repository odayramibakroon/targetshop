class Product {
  final String id;
  final String name;
  final String details;
  final String image;
  final String categoryId;
  final double quantity;
  final double price;
  final bool like;

  Product({
    required this.id,
    required this.name,
    required this.details,
    required this.price,
    required this.image,
    required this.categoryId,
    this.quantity = 0,
     this.like = false,});
}