import 'package:flutter/material.dart';




class Purchase {

  final String id;

  final String date;

  final String totalAmount;

  final List<Map<String, dynamic>> items;




  Purchase({

    required this.id,

    required this.date,

    required this.totalAmount,

    required this.items,

  });

}




class PurchaseHistoryView extends StatelessWidget {

  final List<Purchase> purchases;




  const PurchaseHistoryView({Key? key, required this.purchases}) : super(key: key);




  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text('Purchase History'),

      ),

      body: purchases.isNotEmpty

          ? ListView.builder(

        itemCount: purchases.length,

        itemBuilder: (context, index) {

          final purchase = purchases[index];

          return Card(

            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),

            child: Padding(

              padding: const EdgeInsets.all(10.0),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(

                    'Purchase ID: ${purchase.id}',

                    style: Theme.of(context).textTheme.bodyLarge,

                  ),

                  const SizedBox(height: 5.0),

                  Text('Date: ${purchase.date}'),

                  Text('Total Amount: ${purchase.totalAmount}'),

                  const Divider(),

                  const Text(

                    'Items:',

                    style: TextStyle(fontWeight: FontWeight.bold),

                  ),

                  const SizedBox(height: 5.0),

                  ...purchase.items.map((item) {

                    return Text(

                      '${item["name"]} x${item["quantity"]} - \$${item["price"]}',

                      style: Theme.of(context).textTheme.bodyMedium,

                    );

                  }).toList(),

                ],

              ),

            ),

          );

        },

      )

          : Center(

        child: Text(

          'No purchase history found!',

          style: Theme.of(context).textTheme.bodyLarge,

        ),

      ),

    );

  }

}