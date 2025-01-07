import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart'; // Để chọn file ảnh
import 'dart:io';
import '../../controllers/user_manage_controller.dart';
import '../../../../models/user.dart'; // Import model User

class UpdateUserForm extends StatefulWidget {
  final User user; // Tham số user được truyền vào
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
    // Gọi setUser để gán giá trị user vào các controller
    controller.setUser(widget.user);
    // Cập nhật role dựa trên user
    _role = widget.user.role ? 'Admin' : 'User';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Obx(() => CircleAvatar(
                      radius: 40,
                      backgroundImage: controller.avatar.value != null &&
                          controller.avatar.value!.isNotEmpty
                          ? NetworkImage(controller.avatar.value!)
                          : const AssetImage('assets/images/default_avatar.png')
                      as ImageProvider,
                    )),
                    IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: () {
                        controller.changeAvatar(); // Gọi phương thức đổi avatar
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ..._buildUpdateUserFields(),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveUser,
                  child: const Text('Lưu'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm xây dựng các trường nhập liệu
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
            ? _buildDropdownField(fieldName)
            : _buildTextField(fieldName, fieldIcon, controller!),
      );
    }).toList();
  }

  // Widget cho trường TextField thông thường
  Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  // Widget cho trường Role (Dropdown)
  Widget _buildDropdownField(String label) {
    return DropdownButtonFormField<String>(
      value: _role,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
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

  // Hàm lưu người dùng
  void _saveUser() {
    // Tạo đối tượng User từ các trường nhập liệu
    final updatedUser = User(
      id: widget.user.id,  // Giữ nguyên ID của user
      username: controller.usernameController.text,
      fullname: controller.fullnameController.text,
      email: controller.emailController.text,
      phone: controller.phoneController.text,
      address: controller.addressController.text,
      role: _role == 'Admin', // Nếu _role là 'Admin' thì role = true, ngược lại là false
    );
    // Gọi hàm editUser từ controller
    controller.editUser(updatedUser, context);
  }
}

