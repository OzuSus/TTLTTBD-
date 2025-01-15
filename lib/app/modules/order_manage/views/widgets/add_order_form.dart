import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/order_manage_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOrderForm extends StatefulWidget {
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFBF39C), Color(0xFFE59CFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: Get.back,
                  ),
                  const Expanded(
                    child: Text(
                      'Add Order',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Obx(() => _buildDropdownField(
                        'User Fullname',
                        controller.selectedUserId,
                        controller.users.map((user) {
                          return {'value': user['id'], 'label': user['fullname']};
                        }).toList(),
                      )),
                      const SizedBox(height: 25),
                      _buildDropdownField(
                        'Payment Method',
                        controller.paymentMethod,
                        [
                          {'value': 1, 'label': 'COD'},
                          {'value': 2, 'label': 'Banking'},
                          {'value': 3, 'label': 'QRCode'},
                        ],
                      ),
                      const SizedBox(height: 25),
                      Obx(() => _buildDropdownField(
                        'Product',
                        controller.selectedProductId,
                        controller.products.map((product) {
                          return {'value': product['id'], 'label': product['name']};
                        }).toList(),
                      )),
                      const SizedBox(height: 25),
                      _buildNumberField(
                        'Quantity',
                        Icons.shopping_cart,
                        controller.quantityController,
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 32,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (controller.selectedUserId.value == 0 ||
                                  controller.selectedProductId.value == 0 ||
                                  controller.quantityController.text.isEmpty) {
                                Get.snackbar(
                                    'Lỗi', 'vui lòng chọn đầy đủ thông tin');
                                return;
                              }
                              await controller.addOrderToAPI(context);
                            },
                            child: const Text('Add Order'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              backgroundColor: const Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      String label, RxInt selectedValue, List<Map<String, dynamic>> options) {
    return Obx(() {
      if (options.isEmpty) {
        return const Text('Loading...');
      }

      if (!options.any((option) => option['value'] == selectedValue.value)) {
        selectedValue.value = options.first['value'];
      }

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: DropdownButtonFormField<int>(
          value: selectedValue.value,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: label,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: InputBorder.none,
          ),
          items: options.map((option) {
            return DropdownMenuItem<int>(
              value: option['value'],
              child: Text(option['label'], overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              selectedValue.value = value;
            }
          },
        ),
      );
    });
  }

  Widget _buildNumberField(
      String label, IconData icon, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
