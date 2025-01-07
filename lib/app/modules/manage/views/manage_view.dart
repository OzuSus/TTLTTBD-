import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/manage_controller.dart';

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
          _buildCard(
            title: 'UserManage',
            icon: Icons.person,
            color: Colors.green, // Viền màu xanh
          ),
          _buildCard(
            title: 'ProductManage',
            icon: Icons.shopping_cart,
            color: Colors.green, // Viền màu xanh
          ),
          _buildCard(
            title: 'CategoryManage',
            icon: Icons.folder,
            color: Colors.green, // Viền màu xanh
          ),
          _buildCard(
            title: 'Dashboard',
            icon: Icons.bar_chart,
            color: Colors.green, // Viền màu xanh
          ),
          _buildCard(
            title: 'OrderManage',
            icon: Icons.receipt_long,
            color: Colors.green, // Viền màu xanh
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        if(title =='UserManage'){
          Get.toNamed('/user-manage');
        }
        if(title =='ProductManage'){
          Get.toNamed('/product-manage');
        }
        if(title =='CategoryManage'){
          Get.offNamed(Routes.CATEGORY_MANAGE);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Nền trắng
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 2), // Viền màu xanh
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: color, // Màu biểu tượng
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Chữ đen
              ),
            ),
          ],
        ),
      ),
    );
  }
}
