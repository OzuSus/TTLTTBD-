import 'dart:convert';
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
      appBar: AppBar(
        title: const Text('User Manage'), // Đổi tiêu đề thành "User Manage"
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _onBackPressed,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddUserForm(context);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.users.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          controller: scrollController,
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            User user = controller.users[index];

            return _buildUserDetail(
                context, user); // Hiển thị chi tiết của người dùng
          },
        );
      }),
    );
  }

  // Hàm xử lý quay lại
  void _onBackPressed() {
    Get.back();
  }

  // Hàm hiển thị form thêm người dùng
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
            key: UniqueKey(), user: user); // Truyền user cần cập nhật
      },
    );
  }

  // Widget hiển thị chi tiết của user
  Widget _buildUserDetail(BuildContext context, User user) {
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
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: user.avatar != null &&
                          user.avatar!.isNotEmpty
                          ? NetworkImage(user.avatar!)
                          : const AssetImage(
                          'assets/images/default_avatar.png') as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          controller.changeAvatarForUser(user);
                        },
                        child: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.camera_alt, size: 16, color: Colors
                              .black),
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
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _showUpdateUserForm(
                            context, user); // Hiển thị form chỉnh sửa
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, user);
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Thêm phần hiển thị Full Name
            Row(
              children: [
                const Icon(Icons.person, color: Colors.grey),
                const SizedBox(width: 8.0),
                Text(user.fullname ?? 'No full name provided'),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.grey),
                const SizedBox(width: 8.0),
                Text(user.phone ?? 'No phone number'),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.grey),
                const SizedBox(width: 8.0),
                Text(user.address ?? 'No address provided'),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.verified_user, color: Colors.grey),
                const SizedBox(width: 8.0),
                Text(user.role ? 'Admin' : 'User'),
              ],
            ),
          ],
        ),
      ),
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
