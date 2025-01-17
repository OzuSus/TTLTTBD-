import 'package:ecommerce_app/app/components/no_data.dart';
import 'package:ecommerce_app/app/modules/purchase_history/controllers/purchase_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchaseHistoryView extends GetView<PurchaseHistoryController> {
  const PurchaseHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF64B5F6), // Màu xanh nhạt
              Color(0xFFACFFBC), // Màu xanh dương
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Tiêu đề và nút Back
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    Expanded(
                      child: Text(
                        'Lịch sử đơn hàng đã mua',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Để đảm bảo căn giữa tiêu đề
                  ],
                ),
                const SizedBox(height: 8),

                // Nội dung chính
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (controller.orders.isEmpty) {
                      return const NoData(text: "Bạn chưa có đơn hàng nào!");
                    }
                    return ListView.builder(
                      itemCount: controller.orders.length,
                      itemBuilder: (context, index) {
                        final order = controller.orders[index];
                        int totalQuantity = order.orderDetailList.fold(
                            0, (sum, item) => sum + item.quantity);
                        double totalPrice = order.orderDetailList.fold(
                            0.0,
                                (sum, item) =>
                            sum + item.quantity * item.product.price);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white, // Màu nền trong suốt của container
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.pink.shade50,
                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),
                                        child: const Text(
                                          'MALL',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 12),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Mã đơn ${order.idOrder}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    order.status.name,
                                    style: const TextStyle(
                                        color: Colors.orange, fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Hiển thị danh sách OrderDetail
                              ListView.builder(
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemCount: order.orderDetailList.length,
                                itemBuilder: (context, detailIndex) {
                                  final detail =
                                  order.orderDetailList[detailIndex];
                                  return Row(
                                    children: [
                                      // Product image
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                        ),
                                        child: Image.network(
                                          'http://localhost:8080/uploads/${detail.product.image}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // Product name and pricing
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              detail.product.name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                const SizedBox(width: 8),
                                                Text(
                                                  '${detail.product.price} đ',
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  'x${detail.quantity}',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 12),

                              // Tổng giá tiền
                              Text(
                                'Tổng số tiền ($totalQuantity sản phẩm): $totalPrice đ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
