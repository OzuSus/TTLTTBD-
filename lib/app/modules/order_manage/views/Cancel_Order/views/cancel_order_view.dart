import 'package:flutter/material.dart';

class CancelOrderView extends StatefulWidget {
  final Map<String, dynamic> order;

  const CancelOrderView({Key? key, required this.order}) : super(key: key);

  @override
  _CancelOrderViewState createState() => _CancelOrderViewState();
}

class _CancelOrderViewState extends State<CancelOrderView> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _cancelOrder() {
    // Perform cancellation logic, e.g., API call
    final cancellationData = {
      "orderId": widget.order["id"],
      "reason": _reasonController.text,
    };

    // Mock server response
    Navigator.pop(context, cancellationData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancel Order - ${widget.order["id"]}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to cancel this order?',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason for Cancellation (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  onPressed: _cancelOrder,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Cancel Order'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

}
