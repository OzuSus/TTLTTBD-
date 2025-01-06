// manage_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const ManageCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          Get.snackbar('Tapped', 'You tapped on $title');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Nền trắng
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 2), // Viền màu
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: color, // Màu biểu tượng
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Chữ đen
              ),
            ),
          ],
        ),
      ),
    );
  }
}
