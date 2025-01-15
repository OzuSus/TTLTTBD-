import 'package:ecommerce_app/app/models/order_detail.dart';
import 'package:ecommerce_app/app/models/status.dart';

class Order {
  final int idOrder;
  final int userId;
  final String dateOrder;
  final String paymentMethodName;
  final Status status;
  final List<OrderDetail> orderDetailList;

  Order({
    required this.idOrder,
    required this.userId,
    required this.dateOrder,
    required this.paymentMethodName,
    required this.status,
    required this.orderDetailList,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      idOrder: json['idOrder'] ?? 0,
      userId: json['userId'] ?? 0,
      dateOrder: json['dateOrder'] ?? '',
      paymentMethodName: json['paymentMethodName'] ?? '',
      status: json['statusName'] != null
          ? Status.fromJson(json['statusName'])
          : Status(id: 0, name: ''),
      orderDetailList: json['orderDetails'] != null
          ? (json['orderDetails'] as List<dynamic>)
          .map((detail) => OrderDetail.fromJson(detail))
          .toList()
          : [],
    );
  }

}