import 'package:ecommerce_app/app/modules/order_manage/controllers/order_manage_controller.dart';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/app/modules/order_manage/views/widgets/order_details_view.dart';
import 'package:get/get.dart';
import 'widgets/add_order_form.dart';
import '../../../models/order.dart';

class OrderManageView extends GetView<OrderManageController> {
  const OrderManageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9CB3FB), Color(0xFFB4FA99)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF717BF4), Color(0xFFEA8A11)], // Gradient của header
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: _onBackPressed,
                  ),
                  const Text(
                    'Order Manage',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      _showAddOrderForm(context);
                    },
                  ),
                ],
              ),
            ),

            // Nền chính với gradient khác
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF9CB3FB), Color(0xFFB4FA99)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Obx(() {
                  if (controller.orders.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: controller.orders.length,
                    itemBuilder: (context, index) {
                      final order = controller.orders[index];
                      return _buildOrderList(context, order);
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildOrderList(BuildContext context, Order order) {
    final orderId = order.orderId;

    // Lấy màu sắc dựa trên statusName
    Color getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case "đã xác nhận":
          return Colors.orange;
        case "đã vận chuyển":
          return Colors.lightBlueAccent;
        case "đã giao hàng":
          return Colors.green;
        case "chưa xác nhận":
        default:
          return Colors.red;
      }
    }

    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: $orderId',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: getStatusColor(order.statusName),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    order.statusName,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8.0),

            // Order Info
            Text(
              'User ID: ${order.userId}',
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              'Date: ${order.dateOrder}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Payment Method: ${order.paymentMethodName}',
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 8.0),

            // Footer Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Price: \$${order.totalPrice.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.visibility, color: Colors.blue),
                      onPressed: () {
                        controller.orderId.value = orderId;
                        controller.fetchDetails();
                        _showOrderDetails(context, orderId);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () {
                        controller.selectedStatus.value = order.statusName;
                        _showStatusUpdateDialog(context, orderId, order.statusName);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, orderId);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void _showAddOrderForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddOrderForm();
      },
    );
  }

  void _showOrderDetails(BuildContext context, int orderId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return OrderDetailsView(orderId: orderId);
      },
    );
  }

  _showDeleteConfirmationDialog(BuildContext context, int orderId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text(
              'Bạn có chắc chắn muốn xóa đơn hàng này không?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                controller.orderId.value = orderId;
                Navigator.of(context).pop();
                controller.deleteOrder();
              },
              child: const Text('Xóa', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _onBackPressed() {
    Get.toNamed(Routes.MANAGE);
  }

  void _showStatusUpdateDialog(BuildContext context, int orderId, String currentStatus) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Update Order Status',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: controller.selectedStatus.value,
                    decoration: const InputDecoration(
                      labelText: 'Select Status',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black87),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: InputBorder.none,
                    ),
                    items: controller.statusOptions
                        .map((status) => DropdownMenuItem<String>(
                      value: status,
                      child: Text(
                        status,
                        style: const TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                    ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedStatus.value = value;
                        controller.selectedStatusId.value = getStatusIdByName(value);
                      }
                    },
                  ),
                );
              }),
              const SizedBox(height: 30),
              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.blueAccent, // Adjust color here
                  ),
                  onPressed: () async {
                    await controller.updateOrderStatus(orderId, controller.selectedStatusId.value);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  int getStatusIdByName(String statusName) {
    Map<String, int> statusMapping = {
      'Chưa xác nhận': 5,
      'Đã xác nhận': 6,
      'Đã vận chuyển': 7,
      'Đã giao hàng': 8,
    };

    return statusMapping[statusName] ?? 0;
  }

}