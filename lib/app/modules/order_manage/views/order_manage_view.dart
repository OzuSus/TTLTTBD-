import 'package:ecommerce_app/app/modules/order_manage/controllers/order_manage_controller.dart';
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
      appBar: AppBar(
        title: const Text('Manage Orders'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _onBackPressed,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddOrderForm(context);
            },
          ),
        ],
      ),
      body: Obx(() {
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
    );
  }

  Widget _buildOrderList(BuildContext context, Order order) {
    final orderId = order.orderId;
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
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
                      icon: const Icon(Icons.edit, color: Colors.yellow),
                      onPressed: () {
                        controller.selectedStatus.value = order.statusName; // Set the current status to the selected value
                        _showStatusUpdateDialog(context, orderId, order.statusName);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red), // Nút xóa đơn hàng
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, orderId);
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text('User ID: ${order.userId}'),
            Text('Date: ${order.dateOrder}'),
            Text('Status: ${order.statusName}'),
            Text('Payment Method: ${order.paymentMethodName}'),
            Text('Total Price: ${order.totalPrice.toStringAsFixed(0)}'),
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
        return const AddOrderForm();
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
                    .pop(); // Đóng hộp thoại mà không làm gì cả
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                controller.orderId.value = orderId;
                Navigator.of(context).pop(); // Đóng hộp thoại
                controller.deleteOrder(); // Xóa người dùng
              },
              child: const Text('Xóa', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _onBackPressed() {
    Get.back();
  }

  void _showStatusUpdateDialog(BuildContext context, int orderId, String currentStatus) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Update Order Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              // Dropdown to select status
              Obx(() {
                return DropdownButtonFormField<String>(
                  value: controller.selectedStatus.value,
                  decoration: InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                  items: controller.statusOptions
                      .map((status) => DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectedStatus.value = value;
                      controller.selectedStatusId.value = getStatusIdByName(value); // Lấy statusId
                    }
                  },
                );
              }),
              const SizedBox(height: 20),
              // Save Button
              ElevatedButton(
                onPressed: () async {
                  // Truyền cả statusId khi gọi updateOrderStatus
                  await controller.updateOrderStatus(orderId, controller.selectedStatusId.value);
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

// Hàm giúp lấy statusId từ tên trạng thái
  int getStatusIdByName(String statusName) {
    // Giả sử bạn có một danh sách các trạng thái với id, ví dụ:
    Map<String, int> statusMapping = {
      'Chưa xác nhận': 5,
      'Đã xác nhận': 6,
      'Đã vận chuyển': 7,
      'Đã giao hàng': 8,
    };

    return statusMapping[statusName] ?? 0; // Trả về id mặc định nếu không tìm thấy
  }

}