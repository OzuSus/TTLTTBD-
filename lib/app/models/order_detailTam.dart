import 'package:ecommerce_app/app/models/product.dart';

class OrderDetail {
  final int id;
  final int idOrder;
  final Product product;
  final int quantity;
  final double totalprice;


  OrderDetail({
    required this.id,
    required this.idOrder,
    required this.product,
    required this.quantity,
    required this.totalprice,
  });


  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'] ?? 0,
      idOrder: json['idOder'] ?? 0,
      product: json['idProduct'] != null
          ? Product.fromJson(json['idProduct'])
          : Product(
        id: 0,
        name: '',
        price: 0.0,
        quantity: 0,
        image: '',
        description: '',
        reviewCount: 0,
        rating: 0.0,
        categoryID: 0,
      ),
      quantity: json['quantity'] ?? 0,
      totalprice: (json['totalprice'] as num?)?.toDouble() ?? 0.0,
    );
  }

}