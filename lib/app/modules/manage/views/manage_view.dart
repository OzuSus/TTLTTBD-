// manage_view.dart
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/manage_controller.dart';
import 'widgets/manage_card.dart';

class ManageView extends GetView<ManageController> {
  const ManageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Nền trắng cho AppBar
        elevation: 0, // Loại bỏ bóng của AppBar
        title: const Text(
          'Manage',
          style: TextStyle(
            color: Colors.black, // Chữ đen
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black), // Icon đen
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        padding: const EdgeInsets.all(16.0),
        children: [
          ManageCard(
            title: 'UserManage',
            icon: Icons.person,
            color: Colors.green, // Viền màu xanh
            onTap: () => controller.navigateToUserManage(),
          ),
          ManageCard(
            title: 'ProductManage',
            icon: Icons.shopping_cart,
            color: Colors.green, // Viền màu xanh
            onTap: () => Get.toNamed('/product-manage'),
          ),
          ManageCard(
            title: 'CategoryManage',
            icon: Icons.folder,
            color: Colors.green, // Viền màu xanh
            onTap: () => Get.offNamed(Routes.CATEGORY_MANAGE),
          ),
          ManageCard(
            title: 'Dashboard',
            icon: Icons.bar_chart,
            color: Colors.green, // Viền màu xanh
          ),
          ManageCard(
            title: 'OrderManage',
            icon: Icons.receipt_long,
            color: Colors.green, // Viền màu xanh
          ),
        ],
      ),
    );
  }
}
