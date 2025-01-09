import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/order_manage_controller.dart';
import 'add_product_form.dart'; // Import controller

class AddOrderForm extends StatefulWidget {
  const AddOrderForm({Key? key}) : super(key: key);

  @override
  _AddOrderFormState createState() => _AddOrderFormState();
}

class _AddOrderFormState extends State<AddOrderForm> {
  final OrderManageController controller = Get.put(OrderManageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildTextField('User ID', Icons.person, controller.userIdController),
              const SizedBox(height: 15),
              _buildDropdownField(
                'Payment Method',
                controller.paymentMethod,
                [
                  {'value': 1, 'label': 'COD'},
                  {'value': 2, 'label': 'Banking'},
                  {'value': 3, 'label': 'QRCode'},
                ],
              ),
              const SizedBox(height: 15),
              _buildTextField('Product ID', Icons.qr_code, controller.productIdController),
              const SizedBox(height: 15),
              _buildTextField('Quantity', Icons.production_quantity_limits, controller.quantityController),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: controller.clearOrderForm,
                    child: const Text('Clear'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      backgroundColor: Colors.grey,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await controller.addOrder();
                      _showAddProductForm(context, controller.orderId.value);
                    },
                    child: const Text('Save'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget cho trường TextField
  Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: label == 'Quantity' ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
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

  // Widget cho trường Payment Method (Dropdown)
  Widget _buildDropdownField(
      String label, RxInt selectedValue, List<Map<String, dynamic>> options) {
    return Obx(() => DropdownButtonFormField<int>(
      value: selectedValue.value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      items: options
          .map((option) => DropdownMenuItem<int>(
        value: option['value'],
        child: Text(option['label']),
      ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          selectedValue.value = value;
        }
      },
    ));
  }

  void _showAddProductForm(BuildContext context, int orderId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddProductForm(orderId: orderId); // Truyền orderId vào AddProductForm
      },
    );
  }
}