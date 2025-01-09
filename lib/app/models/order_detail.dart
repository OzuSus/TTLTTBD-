class OrderDetail {
  final int orderDetailId;
  final int orderId;
  final int productId;
  final String productName;
  final double unitPrice;
  final int quantity;
  final double totalPrice;

  OrderDetail({
    required this.orderDetailId,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
  });

  // Factory method để chuyển đổi từ JSON
  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      orderDetailId: json['orderDetailId'] as int,
      orderId: json['orderId'] as int,
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      unitPrice: json['unitPrice'] as double,
      quantity: json['quantity'] as int,
      totalPrice: json['totalPrice'] as double,
    );
  }

  // Phương thức chuyển đối tượng OrderDetail thành JSON
  Map<String, dynamic> toJson() {
    return {
      'orderDetailId': orderDetailId,
      'orderId': orderId,
      'productId': productId,
      'productName': productName,
      'unitPrice': unitPrice,
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }
}
