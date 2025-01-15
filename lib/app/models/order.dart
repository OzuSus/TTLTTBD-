class Order {
  final int orderId;
  final int userId;
  final String dateOrder;
  final int statusId;
  final String statusName;
  final int paymentMethodId;
  final String paymentMethodName;
  final double totalPrice;

  Order({
    required this.orderId,
    required this.userId,
    required this.dateOrder,
    required this.statusId,
    required this.statusName,
    required this.paymentMethodId,
    required this.paymentMethodName,
    required this.totalPrice,
  });

  // Factory method để chuyển đổi từ JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'] as int,
      userId: json['userId'] as int,
      dateOrder: json['dateOrder'] as String,
      statusId: json['statusId'] as int,
      statusName: json['statusName'] as String,
      paymentMethodId: json['paymentMethodId'] as int,
      paymentMethodName: json['paymentMethodName'] as String,
      totalPrice: json['totalPrice'] as double,
    );
  }

  // Phương thức chuyển đối tượng Order thành JSON
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'userId': userId,
      'dateOrder': dateOrder,
      'statusId': statusId,
      'statusName': statusName,
      'paymentMethodId': paymentMethodId,
      'paymentMethodName': paymentMethodName,
      'totalPrice': totalPrice,
    };
  }
}