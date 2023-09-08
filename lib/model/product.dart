class ProductData {
  final String title;
  final String details;
  final int price;
  final double size;
  final List description;
  final List image;
  final String productID;
  final String category;
  bool? favourite;
  ProductData({
    required this.title,
    required this.category,
    required this.details,
    required this.price,
    required this.size,
    required this.description,
    required this.image,
    required this.productID,
    this.favourite,
  });
}
