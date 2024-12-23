import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  final int quantity;
  const QuantitySelector({super.key,required this.quantity,});

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int _quantity;


  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _decreaseQuantity,
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Đặt hình oval
              ),
            ),
            backgroundColor: MaterialStateProperty.all(const Color(0xFF0FDA89)),
          ),
          child: const Icon(Icons.remove, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: 60,
            child: TextField(
              controller: TextEditingController(text: '$_quantity'),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true, // Bật màu nền
                fillColor: const Color(0xFFF1F1F1), // Màu nền
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF0FDA89), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF0FDA89), width: 2.0),
                ),
              ),
              style: const TextStyle(fontSize: 18, color: Color(0xFF0FDA89)),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _increaseQuantity,
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(const Color(0xFF0FDA89)),
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ],
    );
  }
}
