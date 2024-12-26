import 'package:ecommerce_app/app/models/product.dart';
import 'package:ecommerce_app/app/modules/product_manage/controller/product_manage_controller.dart';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: (){
        Get.toNamed(
          Routes.PRODUCT_EDIT,
          arguments: {'id': product.id},
        );
      },
      onLongPressStart: (details) {
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy,
            MediaQuery.of(context).size.width - details.globalPosition.dx,
            MediaQuery.of(context).size.height - details.globalPosition.dy,
          ),
          items: [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, color: Colors.blue),
                  SizedBox(width: 10),
                  Text('Chỉnh sửa'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 10),
                  Text('Xóa'),
                ],
              ),
            ),
          ],
        ).then((value) {
          if (value == 'edit') {
            Get.toNamed(
              Routes.PRODUCT_EDIT,
              arguments: {'id': product.id},
            );
          } else if (value == 'delete') {
            Get.defaultDialog(
              title: 'Xác nhận',
              middleText: 'Bạn có chắc chắn muốn xóa sản phẩm này không?',
              textConfirm: 'Xóa',
              textCancel: 'Hủy',
              confirmTextColor: Colors.white,
              cancelTextColor: Colors.green,
              buttonColor: Colors.green,
              onConfirm: () {
                final controller = Get.find<ProductManageController>();
                controller.deleteProduct(product.id);
                Get.back();
              },
              onCancel: () {},
            );
          }
        });
      },

      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: Image.network(
                    'http://localhost:8080/uploads/${product.image}',
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            Text(
              product.name,
              style: theme.textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
                .animate()
                .fade()
                .slideY(
              duration: const Duration(milliseconds: 200),
              begin: 1,
              curve: Curves.easeInSine,
            ),
            5.verticalSpace,
            Text('\$${product.price}', style: theme.textTheme.displaySmall)
                .animate()
                .fade()
                .slideY(
              duration: const Duration(milliseconds: 200),
              begin: 2,
              curve: Curves.easeInSine,
            ),
          ],
        ),
      ),
    );
  }
}


