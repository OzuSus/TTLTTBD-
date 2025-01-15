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
      id: json['id'] as int,
      idOrder: json['idOrder'] as int,
      product: Product.fromJson(json['idProduct']),
      quantity: json['quanity'] as int,
      totalprice: json['totalprice'] as double,
    );
  }
}