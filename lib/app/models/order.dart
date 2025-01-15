import 'package:ecommerce_app/app/models/status.dart';

class Order {
  final int idOrder;
  final int userId;
  final String dateOrder;
  final String paymentMethodName;
  final Status status;

  Order({
    required this.idOrder,
    required this.userId,
    required this.dateOrder,
    required this.paymentMethodName,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      idOrder: json['idOrder'] as int,
      userId: json['userId'] as int,
      dateOrder: json['dateOrder'] as String,
      paymentMethodName: json['paymentMethodName'] as String,
      status: Status.fromJson(json['statusName']),
    );
  }
}