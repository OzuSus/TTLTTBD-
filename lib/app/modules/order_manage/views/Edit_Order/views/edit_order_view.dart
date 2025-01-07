import 'package:flutter/material.dart';

class EditOrderView extends StatefulWidget {
  final Map<String, dynamic> order;

  const EditOrderView({Key? key, required this.order}) : super(key: key);

  @override
  _EditOrderViewState createState() => _EditOrderViewState();
}

class _EditOrderViewState extends State<EditOrderView> {
  late TextEditingController _totalController;
  late TextEditingController _productController;
  late String _selectedStatus;

  final List<String> _statusOptions = [
    'Pending',
    'Processing',
    'Shipped',
    'Delivered',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.order['status']; // Initialize with current status
    _totalController = TextEditingController(text: widget.order['total']?.toString() ?? '');
    _productController = TextEditingController(text: widget.order['product']?.toString() ?? '');
  }

  @override
  void dispose() {
    _totalController.dispose();
    _productController.dispose();
    super.dispose();
  }

  void _saveOrder() {
    if (_totalController.text.isEmpty || double.tryParse(_totalController.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid total amount.')),
      );
      return;
    }

    if (_productController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product field cannot be empty.')),
      );
      return;
    }

    final updatedOrder = {
      ...widget.order,
      'status': _selectedStatus,
      'total': _totalController.text,
      'product': _productController.text,
    };

    Navigator.pop(context, updatedOrder);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Order - ${widget.order["id"]}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Order Status',
                border: OutlineInputBorder(),
              ),
              items: _statusOptions.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedStatus = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _totalController,
              decoration: const InputDecoration(
                labelText: 'Total Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _productController,
              decoration: const InputDecoration(
                labelText: 'Product',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _saveOrder,
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
