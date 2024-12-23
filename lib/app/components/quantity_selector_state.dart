import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({super.key});

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int _quantity = 1;

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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$_quantity',
            style: const TextStyle(fontSize: 18, color: Color(0xFF0FDA89)),
          ),
        ),
        ElevatedButton(
          onPressed: _increaseQuantity,
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Đặt hình oval
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
