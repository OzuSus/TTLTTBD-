import 'package:ecommerce_app/app/components/custom_snackbar.dart';
import 'package:ecommerce_app/app/routes/app_pages.dart';
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
  var selectedStatus = ''.obs;
  var selectedStatusId = 0.obs;
  final List<String> statusOptions = ['Chưa xác nhận', 'Đã xác nhận', 'Đã vận chuyển', 'Đã giao hàng'];

  TextEditingController userIdController = TextEditingController();
  TextEditingController productIdController = TextEditingController();

  final TextEditingController quantityController = TextEditingController();

  final RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> products = <Map<String, dynamic>>[].obs;

  final RxInt selectedUserId = 0.obs;
  final RxInt selectedProductId = 0.obs;
  final RxInt paymentMethod = 1.obs;


  @override
  void onInit() {
    super.onInit();
    fetchOrders();
    fetchUsers();
    fetchProducts();
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
    String url = 'http://localhost:8080/api/orders/${orderId.value}/details';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> fetchedDetails = json.decode(response.body);
        details.value = fetchedDetails.map((json) {
          return OrderDetail.fromJson({
            ...json,
            'totalPrice': double.tryParse(json['totalPrice'].toString()) ?? 0.0,
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
  Future<void> fetchUsers() async {
    const String url = 'http://localhost:8080/api/users';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> fetchedUsers = json.decode(response.body);
        users.value = fetchedUsers
            .map((user) => {'id': user['id'], 'fullname': user['fullname']})
            .toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch users. Code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch users: $e');
    }
  }

  Future<void> fetchProducts() async {
    const String url = 'http://localhost:8080/api/products';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> fetchedProducts = json.decode(response.body);
        products.value = fetchedProducts
            .map((product) => {'id': product['id'], 'name': product['name']})
            .toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch products. Code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
    }
  }

  Future<void> addOrder() async {
    try {
      const String url = 'http://localhost:8080/api/orders/place';
      final uri = Uri.parse(url).replace(queryParameters: {
        'idUser': userIdController.text,
        'idPaymentMethop': paymentMethod.value.toString(),
      });

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
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

  void clearOrderForm() {
    userIdController.clear();
    paymentMethod.value = 1;
    productIdController.clear();
    quantityController.clear();
  }

  void deleteOrder() async{
    try {
      final response = await http.delete(
        Uri.parse('http://localhost:8080/api/orders/${orderId.value}'),
      );

      if (response.statusCode == 200) {
        CustomSnackBar.showCustomSnackBar(
          title: 'Đơn hàng',
          message: 'Xóa đơn hàng thành công',
        );
        fetchOrders();
      } else {
        Get.snackbar('Error', 'Failed to delete order');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
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
        CustomSnackBar.showCustomSnackBar(
          title: 'Đơn hàng',
          message: 'Cập nhập trạng thái đơn hàng thành công',
        );
        fetchOrders();
      } else {
        Get.snackbar('Error', 'Failed to update status');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  Future<void> addOrderToAPI(BuildContext context) async {
    const String url = 'http://localhost:8080/api/orders/create';
    try {
      final body = {
        "idUser": selectedUserId.value,
        "idPaymentMethop": paymentMethod.value,
        "products": [
          {
            "idProduct": selectedProductId.value,
            "quantity": int.parse(quantityController.text),
          }
        ]
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        CustomSnackBar.showCustomSnackBar(
          title: 'Đơn hàng',
          message: 'Thêm đơn hàng thành công',
        );
        Navigator.pop(context);
      } else {
        Get.snackbar('Error', 'Failed to add order. Code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

}