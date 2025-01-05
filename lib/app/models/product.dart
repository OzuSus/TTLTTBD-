class Product {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final String image;
  final String description;
  final int reviewCount;
  final double rating;
  final int categoryID;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    required this.description,
    required this.reviewCount,
    required this.rating,
    required this.categoryID,
  });

  // copyWith để cập nhật dữ liệu
  Product copyWith({
    int? id,
    String? name,
    double? price,
    int? quantity,
    String? image,
    String? description,
    int? reviewCount,
    double? rating,
    int? categoryID,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      description: description ?? this.description,
      reviewCount: reviewCount ?? this.reviewCount,
      rating: rating ?? this.rating,
      categoryID: categoryID ?? this.categoryID,
    );
  }
  // Phương thức parse từ JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
      image: json['image'],
      description: json['description'],
      reviewCount: json['reviewCount'],
      rating: (json['rating'] as num).toDouble(),
      categoryID: json['categoryID'],
    );
  }
}
