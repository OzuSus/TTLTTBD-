import 'dart:convert';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_manage_controller.dart'; // Import controller của UserManage
import 'widgets/add_user_form.dart'; // Import AddUserForm
import 'widgets/update_user_form.dart'; // Import UpdateUserForm
import '../../../models/user.dart'; // Import model User

class UserManageView extends GetView<UserManageController> {
  const UserManageView({Key? key}) : super(key: key);

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
            // Header với gradient
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF471BB), Color(0xFF77D0F6)],
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
                    'User Manage',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      _showAddUserForm(context);
                    },
                  ),
                ],
              ),
            ),
            // Nội dung chính
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
                  if (controller.users.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) {
                      final user = controller.users[index];
                      return _buildUserDetail(context, user);
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


  void _onBackPressed() {
    Get.toNamed(Routes.MANAGE);
  }

  void _showAddUserForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const AddUserForm();
      },
    );
  }

  void _showUpdateUserForm(BuildContext context, User user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return UpdateUserForm(
            key: UniqueKey(), user: user);
      },
    );
  }

  Widget _buildUserDetail(BuildContext context, User user) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Avatar, Username, Email, Actions
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: user.avatar != null && user.avatar!.isNotEmpty
                          ? NetworkImage(user.avatar!)
                          : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          controller.changeAvatarForUser(user);
                        },
                        child: const CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.camera_alt, size: 18, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.username,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blueAccent),
                      onPressed: () {
                        _showUpdateUserForm(context, user);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, user);
                      },
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 24.0, thickness: 1.0),
            // User details
            _buildDetailRow(Icons.person, "Full Name", user.fullname ?? 'No full name provided'),
            const SizedBox(height: 12.0),
            _buildDetailRow(Icons.phone, "Phone", user.phone ?? 'No phone number'),
            const SizedBox(height: 12.0),
            _buildDetailRow(Icons.location_on, "Address", user.address ?? 'No address provided'),
            const SizedBox(height: 12.0),
            _buildDetailRow(Icons.verified_user, "Role", user.role ? 'Admin' : 'User'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueGrey),
        const SizedBox(width: 12.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }


  void _showDeleteConfirmationDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text(
              'Bạn có chắc chắn muốn xóa người dùng này không?'),
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
                Navigator.of(context).pop(); // Đóng hộp thoại
                controller.deleteUser(user); // Xóa người dùng
              },
              child: const Text('Xóa', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
