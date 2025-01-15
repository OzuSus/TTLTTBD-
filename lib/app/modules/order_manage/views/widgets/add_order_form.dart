import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/order_manage_controller.dart';

class AddOrderForm extends StatefulWidget {
  const AddOrderForm({Key? key}) : super(key: key);

  @override
  _AddOrderFormState createState() => _AddOrderFormState();
}

class _AddOrderFormState extends State<AddOrderForm> {
  final OrderManageController controller = Get.put(OrderManageController());

  @override
  void initState() {
    super.initState();
    controller.fetchUsers();
    controller.fetchProducts();
  }

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
              Obx(() => _buildDropdownField(
                'User Fullname',
                controller.selectedUserId,
                controller.users.map((user) {
                  return {'value': user['id'], 'label': user['fullname']};
                }).toList(),
              )),
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
              Obx(() => _buildDropdownField(
                'Product',
                controller.selectedProductId,
                controller.products.map((product) {
                  return {'value': product['id'], 'label': product['name']};
                }).toList(),
              )),
              const SizedBox(height: 15),
              _buildNumberField('Quantity', Icons.shopping_cart, controller.quantityController),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.selectedUserId.value == 0 ||
                        controller.selectedProductId.value == 0 ||
                        controller.quantityController.text.isEmpty) {
                      Get.snackbar('Error', 'Please fill all fields before adding an order.');
                      return;
                    }
                    await controller.addOrderToAPI(context);
                  },
                  child: const Text('Add Order'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
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

  Widget _buildDropdownField(String label, RxInt selectedValue, List<Map<String, dynamic>> options) {
    return Obx(() {
      if (options.isEmpty) {
        return const Text('Loading...');
      }

      // Đảm bảo giá trị mặc định hợp lệ
      if (!options.any((option) => option['value'] == selectedValue.value)) {
        selectedValue.value = options.first['value'];
      }

      return DropdownButtonFormField<int>(
        value: selectedValue.value,
        isExpanded: true, // Mở rộng toàn bộ chiều ngang
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        items: options.map((option) {
          return DropdownMenuItem<int>(
            value: option['value'],
            child: Text(
              option['label'],
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            selectedValue.value = value;
          }
        },
      );

    });
  }


  Widget _buildNumberField(String label, IconData icon, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
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
}
