import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../models/order.dart';
import '../../../models/order_detail.dart';

class OrderManageController extends GetxController {
  var orders = <Order>[].obs;
  var details = <OrderDetail>[].obs;
  RxInt orderId = 0.obs;
  RxInt detailId = 0.obs;
  var selectedStatus = ''.obs; // Đang lưu tên trạng thái
  var selectedStatusId = 0.obs; // Thêm một biến lưu statusId
  final List<String> statusOptions = ['Chưa xác nhận', 'Đã xác nhận', 'Đã vận chuyển', 'Đã giao hàng']; // Status options

  TextEditingController userIdController = TextEditingController();
  RxInt paymentMethod = 1.obs;
  TextEditingController productIdController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    const String url = 'http://localhost:8080/api/orders';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> fetchedOrders = json.decode(response.body);
        orders.value = fetchedOrders.map((json) {
          return Order.fromJson({
            ...json,
          });
        }).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch orders. Code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch orders: $e');
    }
  }

  Future<void> fetchDetails() async {
    print(orderId.value);
    String url = 'http://localhost:8080/api/orders/${orderId.value}/details'; // Thay bằng URL API thực tế
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> fetchedDetails = json.decode(response.body);
        details.value = fetchedDetails.map((json) {
          // Chuyển đổi dữ liệu order từ API thành đối tượng Order
          return OrderDetail.fromJson({
            ...json,
            // Tùy chỉnh thêm nếu cần, ví dụ:
            'totalPrice': double.tryParse(json['totalPrice'].toString()) ?? 0.0, // Đảm bảo totalPrice là double
          });
        }).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch details. Code: ${response.statusCode}');
        print(response.statusCode);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch details: $e');
      print(e);
    }
  }

  // Hàm thêm đơn hàng
  Future<void> addOrder() async {
    try {
      const String url = 'http://localhost:8080/api/orders/place';
      final uri = Uri.parse(url).replace(queryParameters: {
        'idUser': userIdController.text,
        'idPaymentMethop': paymentMethod.value.toString(), // Chuyển thành chuỗi
        'productId': productIdController.text,
        'quantity': quantityController.text, // Chuyển thành chuỗi
      });

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        orderId.value = int.parse(response.body);
        Get.snackbar('Success', 'Order added successfully.');
        fetchOrders();
        clearOrderForm();
      } else {
        Get.snackbar('Error', 'Failed to add order. Code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add order: $e');
    }
  }

  // Hàm xóa dữ liệu form
  void clearOrderForm() {
    userIdController.clear();
    paymentMethod.value = 1;
    productIdController.clear();
    quantityController.clear();
  }

  void addProduct () async{
    try {
      final String url = 'http://localhost:8080/api/orders/${orderId.value}/add-product';
      final uri = Uri.parse(url).replace(queryParameters: {
        'productId': productIdController.text,
        'quantity': quantityController.text, // Chuyển thành chuỗi
      });

      final response = await http.put(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Product added successfully.');
        clearProductForm();
        fetchDetails();
      } else {
        Get.snackbar('Error', 'Failed to add product. Code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add product: $e');
    }
  }

  void clearProductForm() {
    productIdController.clear();
    quantityController.clear();
  }

  void deleteOrder() async{
    try {
      // Gửi yêu cầu DELETE đến API
      final response = await http.delete(
        Uri.parse('http://localhost:8080/api/orders/${orderId.value}'),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Order has been deleted');
        fetchOrders(); // Làm mới danh sách người dùng
      } else {
        Get.snackbar('Error', 'Failed to delete order');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  void deleteProduct() async{
    int? productId;
    for (var detail in details) {
      if (detail.orderDetailId == detailId.value) {
        productId = detail.productId;
        break;
      }
    }
    print(productId);
    try {
      final String url = 'http://localhost:8080/api/orders/${orderId.value}/remove-product';
      final uri = Uri.parse(url).replace(queryParameters: {
        'productId': productId.toString(),
      });

      final response = await http.delete(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Product deleted successfully.');
        fetchDetails();
      } else {
        Get.snackbar('Error', 'Failed to delete product. Code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete product: $e');
    }
  }

  Future<void> updateOrderStatus(int orderId, int statusId) async {
    try {
      final String url = 'http://localhost:8080/api/orders/${orderId}/update-status';
      final uri = Uri.parse(url).replace(queryParameters: {
        'statusId': statusId.toString(),
      });

      final response = await http.put(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Order status updated');
        fetchOrders(); // Fetch the updated order list
      } else {
        Get.snackbar('Error', 'Failed to update status');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

}