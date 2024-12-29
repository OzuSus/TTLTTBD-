import 'package:flutter/material.dart';

class EditOrderView extends StatefulWidget {
  final Map<String, dynamic> order;

  const EditOrderView({Key? key, required this.order}) : super(key: key);

  @override
  _EditOrderViewState createState() => _EditOrderViewState();
}

class _EditOrderViewState extends State<EditOrderView> {
  late TextEditingController _statusController;
  late TextEditingController _totalController;

  @override
  void initState() {
    super.initState();
    _statusController = TextEditingController(text: widget.order['status']);
    _totalController = TextEditingController(text: widget.order['total'].toString());
  }

  @override
  void dispose() {
    _statusController.dispose();
    _totalController.dispose();
    super.dispose();
  }

  void _saveOrder() {
    // Mock API call or database update
    final updatedOrder = {
      ...widget.order,
      'status': _statusController.text,
      'total': _totalController.text,
    };

    Navigator.pop(context, updatedOrder);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Order - ${widget.order["id"]}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _statusController,
              decoration: const InputDecoration(
                labelText: 'Order Status',
                border: OutlineInputBorder(),
              ),
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
