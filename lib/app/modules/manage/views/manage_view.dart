import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/manage_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageView extends GetView<ManageController> {
  const ManageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFABFFFF), Color(0xFFFFF2AE)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Get.toNamed(Routes.BASE),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 28,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Text(
                      'Manage',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildCard(
                      title: 'UserManage',
                      icon: Icons.person,
                      color: Colors.green,
                    ),
                    _buildCard(
                      title: 'ProductManage',
                      icon: Icons.shopping_cart,
                      color: Colors.blue,
                    ),
                    _buildCard(
                      title: 'CategoryManage',
                      icon: Icons.folder,
                      color: Colors.orange,
                    ),
                    _buildCard(
                      title: 'OrderManage',
                      icon: Icons.receipt_long,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
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
        if (title == 'UserManage') {
          Get.toNamed('/user-manage');
        }
        if (title == 'ProductManage') {
          Get.toNamed('/product-manage');
        }
        if (title == 'CategoryManage') {
          Get.offNamed(Routes.CATEGORY_MANAGE);
        }
        if (title == 'OrderManage') {
          Get.toNamed('/order-manage');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: color,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
