import 'package:flutter/material.dart';

class Purchase {
  final String id;
  final String date;
  final String totalAmount;

  Purchase({
    required this.id,
    required this.date,
    required this.totalAmount,

  });
}


class PurchaseHistoryView extends StatelessWidget {
  final List<Purchase> purchases;
  const PurchaseHistoryView({Key? key, required this.purchases}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử đơn hàng đã mua'),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(64, 223, 159, 1.0), // Màu viền
                        width: 2, // Độ dày viền
                      ),
                      borderRadius: BorderRadius.circular(5), // Bo góc (nếu cần)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5), // Bo góc đồng bộ với viền
                      child: Image.network(
                        'http://localhost:8080/uploads/product23.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Purchase ID: ${purchase.id}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 5.0),
                      Text('Date: ${purchase.date}'),
                      Text('Total Amount() : ${purchase.totalAmount}'),


                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.black, width: 2),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Đánh giá',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(width: 10),

                          // Nút "Mua lại"
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color.fromRGBO(64, 223, 159, 1.0), width: 2),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Mua lại',
                              style: TextStyle(color: Color.fromRGBO(64, 223, 159, 1.0)), // Chữ màu đen
                            ),
                          ),
                        ],
                      )



                    ],

                  ),
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