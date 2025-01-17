import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart'; // Để chọn file ảnh
import 'dart:io';
import '../../controllers/user_manage_controller.dart';
import '../../../../models/user.dart'; // Import model User

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateUserForm extends StatefulWidget {
  final User user;

  const UpdateUserForm({Key? key, required this.user}) : super(key: key);

  @override
  _UpdateUserFormState createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  final UserManageController controller = Get.put(UserManageController());
  String? _role = 'User';

  @override
  void initState() {
    super.initState();
    controller.setUser(widget.user);
    _role = widget.user.role ? 'Admin' : 'User';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Hình nền
          Positioned.fill(
            child: Image.asset(
              'assets/images/background_account.png', // Đường dẫn hình nền
              fit: BoxFit.cover,
            ),
          ),
          // Nội dung chính
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Thanh tiêu đề
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black87),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const Expanded(
                        child: Text(
                          'Update User',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // Giữ khoảng trống thay cho nút back
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Form cập nhật
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Avatar và nút camera
                          Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: controller.avatar.value != null &&
                                      controller.avatar.value!.isNotEmpty
                                      ? NetworkImage(controller.avatar.value!)
                                      : const AssetImage('assets/images/default_avatar.png')
                                  as ImageProvider,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.changeAvatar();
                                    },
                                    child: const CircleAvatar(
                                      radius: 14,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Các trường thông tin người dùng
                          ..._buildUpdateUserFields(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildUpdateUserFields() {
    final fields = [
      {'label': 'Username', 'icon': Icons.person, 'controller': controller.usernameController},
      {'label': 'Fullname', 'icon': Icons.badge, 'controller': controller.fullnameController},
      {'label': 'Email', 'icon': Icons.email, 'controller': controller.emailController},
      {'label': 'Phone', 'icon': Icons.phone, 'controller': controller.phoneController},
      {'label': 'Address', 'icon': Icons.location_on, 'controller': controller.addressController},
      {'label': 'Role', 'icon': Icons.accessibility_new, 'isDropdown': true},
    ];

    return fields.map((field) {
      final fieldName = field['label'] as String;
      final fieldIcon = field['icon'] as IconData;
      final controller = field['controller'] as TextEditingController?;
      final isDropdown = field.containsKey('isDropdown') ? field['isDropdown'] as bool : false;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: isDropdown
            ? Column(
          children: [
            _buildDropdownField(fieldName),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Lưu',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        )
            : _buildTextField(fieldName, fieldIcon, controller!),
      );
    }).toList();
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label) {
    return DropdownButtonFormField<String>(
      value: _role,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
      items: const [
        DropdownMenuItem(value: 'User', child: Text('User')),
        DropdownMenuItem(value: 'Admin', child: Text('Admin')),
      ],
      onChanged: (value) {
        setState(() {
          _role = value;
          controller.isAdmin.value = _role == 'Admin';
        });
      },
    );
  }

  void _saveUser() {
    final updatedUser = User(
      id: widget.user.id,
      username: controller.usernameController.text,
      fullname: controller.fullnameController.text,
      email: controller.emailController.text,
      phone: controller.phoneController.text,
      address: controller.addressController.text,
      role: _role == 'Admin',
    );
    controller.editUser(updatedUser, context);
  }
}
