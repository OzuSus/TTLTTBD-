import 'package:flutter/material.dart';
import 'package:ecommerce_app/app/modules/order_manage/views/View_Details/views/order_details_view.dart';
import 'package:ecommerce_app/app/modules/order_manage/views/Edit_Order/views/edit_order_view.dart';
import 'package:ecommerce_app/app/modules/order_manage/views/Cancel_Order/views/cancel_order_view.dart';

class OrderManageView extends StatefulWidget {
  const OrderManageView({Key? key}) : super(key: key);

  @override
  _OrderManageViewState createState() => _OrderManageViewState();
}

class _OrderManageViewState extends State<OrderManageView> {
  List<Map<String, dynamic>> orders = [
    {
      "id": "ORD001",
      "date": "2024-12-30",
      "status": "Pending",
      "total": "\$150.00",
      "items": [
        {"name": "Product A", "quantity": 2, "price": 50},
        {"name": "Product B", "quantity": 1, "price": 50},
      ]
    },
    {
      "id": "ORD002",
      "date": "2024-12-30",
      "status": "Pending",
      "total": "\$150.00",
      "items": [
        {"name": "Product A", "quantity": 2, "price": 50},
        {"name": "Product B", "quantity": 1, "price": 50},
      ]
    },
    {
      "id": "ORD003",
      "date": "2024-12-30",
      "status": "Pending",
      "total": "\$150.00",
      "items": [
        {"name": "Product A", "quantity": 2, "price": 50},
        {"name": "Product B", "quantity": 1, "price": 50},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Orders'),
        centerTitle: true,
      ),

      body: orders.isEmpty
          ? const Center(child: Text('No orders available'))
          : ListView.builder(

      body: ListView.builder(

        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Order ID: ${order["id"]}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ${order["date"]}'),

                  Text('Status: ${order["status"]}',
                      style: TextStyle(
                        color: order["status"] == "Pending"
                            ? Colors.orange
                            : Colors.green,
                      )),

                  Text('Status: ${order["status"]}'),

                  Text('Total: ${order["total"]}'),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),

                onPressed: () => _showOrderActions(context, order),
              ),
            ),
          );
        },
      ),
    );
  }



                onPressed: () {
                  _showOrderActions(context, order);
                },
              ),
            ),
          );
        },
      ),
    );
  }


  void _showOrderActions(BuildContext context, Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOrderAction(
              context,
              icon: Icons.remove_red_eye,
              label: 'View Details',

        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.remove_red_eye),
              title: const Text('View Details'),

              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailsView(order: order),
                  ),
                );
              },
            ),

            _buildOrderAction(
              context,
              icon: Icons.edit,
              label: 'Edit Order',

            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Order'),

              onTap: () async {
                Navigator.pop(context);
                final updatedOrder = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditOrderView(order: order),
                  ),
                );
                if (updatedOrder != null) {
                  setState(() {
                    order.addAll(updatedOrder);
                  });
                }
              },
            ),

            _buildOrderAction(
              context,
              icon: Icons.delete,
              label: 'Cancel Order',

            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Cancel Order'),

              onTap: () async {
                Navigator.pop(context);
                final cancellationData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CancelOrderView(order: order),
                  ),
                );
                if (cancellationData != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Order ${cancellationData["orderId"]} cancelled for reason: ${cancellationData["reason"]}',
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }


  Widget _buildOrderAction(BuildContext context,
      {required IconData icon, required String label, required Function() onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
    );
  }
}

}

