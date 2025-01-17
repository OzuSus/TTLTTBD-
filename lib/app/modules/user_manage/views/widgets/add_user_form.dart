import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../controllers/user_manage_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({Key? key}) : super(key: key);

  @override
  _AddUserFormState createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final UserManageController controller = Get.put(UserManageController());
  bool _isPasswordVisible = false;
  String? _role = 'User';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEAE0AB), Color(0xFFC7FAC3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Expanded(
                      child: Text(
                        'Add User',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Giữ khoảng trống thay cho nút back
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: controller.avatar.value != null &&
                                    controller.avatar.value!.isNotEmpty
                                    ? NetworkImage(controller.avatar.value!)
                                    : const AssetImage(
                                    'assets/images/default_avatar.png')
                                as ImageProvider,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ..._buildAddUserFields(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAddUserFields() {
    final fields = [
      {'label': 'Username', 'icon': Icons.person, 'controller': controller.usernameController},
      {'label': 'Fullname', 'icon': Icons.badge, 'controller': controller.fullnameController},
      {'label': 'Email', 'icon': Icons.email, 'controller': controller.emailController},
      {'label': 'Phone', 'icon': Icons.phone, 'controller': controller.phoneController},
      {'label': 'Address', 'icon': Icons.location_on, 'controller': controller.addressController},
      {'label': 'Password', 'icon': Icons.lock, 'controller': controller.passwordController, 'isPassword': true},
      {'label': 'Role', 'icon': Icons.accessibility_new, 'isDropdown': true},
    ];

    return fields.map((field) {
      final fieldName = field['label'] as String;
      final fieldIcon = field['icon'] as IconData;
      final controller = field['controller'] as TextEditingController?;
      final isPassword = field.containsKey('isPassword') ? field['isPassword'] as bool : false;
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
                  backgroundColor: Colors.white70,
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        )
            : isPassword
            ? _buildPasswordField(fieldName, fieldIcon, controller!)
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

  Widget _buildPasswordField(String label, IconData icon, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        prefixIcon: Icon(icon),
        suffixIcon: IconButton(
          icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
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
    controller.addUser(context);
  }
}

