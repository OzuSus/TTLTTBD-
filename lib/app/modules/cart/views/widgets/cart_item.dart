import 'package:ecommerce_app/app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';
import '../../../../data/models/product_model.dart';
import '../../controllers/cart_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItem extends GetView<CartController> {
  final Product product;
  const CartItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25.r),
            child: Container(
              width: 105.w,
              height: 125.h,
              color: const Color(0xFFEDF1FA),
              child: Image.network(
                'http://localhost:8080/uploads/${product.image}',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.broken_image,
                  size: 50.w,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          20.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.verticalSpace,
                Text(
                  product.name!,
                  style: theme.textTheme.displayMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                5.verticalSpace,
                Text(
                  '\$${product.price}',
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontSize: 18.sp,
                  ),
                ),
                10.verticalSpace,
                GetBuilder<CartController>(
                  id: 'ProductQuantity',
                  builder: (controller) => Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => controller.onDecreasePressed(
                          product.id,
                          context,
                              () => _showDeleteConfirmationDialog(context, controller, product.id!),
                        ),
                      ),

                      Text(
                        '${controller.products.firstWhere((p) => p.id == product.id).quantity}',
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => controller.onIncreasePressed(product.id),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Nút xóa
          InkWell(
            onTap: () => _showDeleteConfirmationDialog(context, controller, product.id!),
            customBorder: const CircleBorder(),
            child: Container(
              padding: EdgeInsets.all(10.r),
              child: SvgPicture.asset(
                Constants.cancelIcon,
                width: 20.w,
                height: 20.h,
                color: theme.textTheme.bodyMedium!.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, CartController controller, int productId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận xóa'),
          content: const Text('Bạn có chắc mốn xóa sản phẩm này khỏi giỏ hàng ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.onDeletePressed(productId);
              },
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );
  }
}
