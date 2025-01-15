import 'package:ecommerce_app/app/models/order_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/order_manage_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9CB3FB), Color(0xFFB4FA99)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: Get.back,
                  ),
                  Expanded(
                    child: Text(
                      'Chi tiết đơn hàng: ${widget.orderId}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
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
            ),
          ],
        ),
      ),
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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail ID: $detailId',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 12.0),
            _buildDetailRow('Product Name:', detail.productName),
            _buildDetailRow('Unit Price:', detail.unitPrice.toString()),
            _buildDetailRow('Quantity:', detail.quantity.toString()),
            _buildDetailRow('Total Price:', detail.totalPrice.toString()),
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
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Tooltip(
                message: value,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
