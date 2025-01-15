import 'package:ecommerce_app/app/models/order_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/order_manage_controller.dart';

class OrderDetailsView extends StatefulWidget {
  final int orderId;

  const OrderDetailsView({Key? key, required this.orderId}) : super(key: key);

  @override
  _OrderDetailsViewState createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  final OrderManageController controller = Get.put(OrderManageController());

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      backgroundColor: Colors.lightBlue, // Background màu sáng để tạo cảm giác hiện đại
      appBar: AppBar(
        title: Text('Order ID: ${widget.orderId}', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent, // Làm cho AppBar trong suốt
        elevation: 0, // Loại bỏ bóng
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: Get.back,
        ),
      ),
      body: Obx(() {
        if (controller.details.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          controller: scrollController,
          itemCount: controller.details.length,
          itemBuilder: (context, index) {
            final detail = controller.details[index];
            return _buildDetailList(context, detail);
          },
        );
      }),
    );
  }

  Widget _buildDetailList(BuildContext context, OrderDetail detail) {
    final detailId = detail.orderDetailId;
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Detail ID: $detailId',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            _buildDetailRow('Product Name:', detail.productName),
            _buildDetailRow('Unit Price:', detail.unitPrice.toString()), // Chuyển đổi sang chuỗi
            _buildDetailRow('Quantity:', detail.quantity.toString()), // Chuyển đổi sang chuỗi
            _buildDetailRow('Total Price:', detail.totalPrice.toString()), // Chuyển đổi sang chuỗi
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

