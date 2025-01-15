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
      appBar: AppBar(
        title: Text('Order Details - Order ID: ${widget.orderId}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                  'Order Detail ID: $detailId',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text('Product Name: ${detail.productName}'),
            Text('Unit Price: ${detail.unitPrice}'),
            Text('Quantity: ${detail.quantity}'),
            Text('Total Price: ${detail.totalPrice}'),
          ],
        ),
      ),
    );
  }
}
