import 'dart:convert';

import 'package:ecommerce_app/app/models/product.dart';
import 'package:ecommerce_app/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:ecommerce_app/utils/UserUtils.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_pages.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  Future<int> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userInfo = prefs.getString('user_info');
    if (userInfo != null) {
      final Map<String, dynamic> userMap = json.decode(userInfo);
      return userMap['id'];
    }
    throw Exception("User not logged in");
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.PRODUCT_DETAILS,
          arguments: {'id': product.id},
        );
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
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: GetBuilder<FavoritesController>(
                    init: FavoritesController(),
                    id: 'FavoriteButton',
                    builder: (controller) => GestureDetector(
                      onTap: () async {
                        final userId = await UserUtils.getUserId();
                        final isFavorite = controller.isFavorite(product.id);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                                isFavorite ? "Xóa khỏi danh sách yêu thích" : "Thêm vào danh sách yêu thích"),
                            content: Text(
                                isFavorite
                                    ? "Bạn có chắc chắn muốn xóa sản phẩm này khỏi danh sách yêu thích?"
                                    : "Bạn có chắc chắn muốn thêm sản phẩm này vào danh sách yêu thích?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Hủy"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  if (isFavorite) {
                                    await controller.removeFavorite(userId, product.id);
                                  } else {
                                    await controller.addFavorite(userId, product.id);
                                  }
                                  controller.update(['FavoriteButton']);
                                },
                                child: const Text("Đồng ý"),
                              ),
                            ],
                          ),
                        );
                      },

                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                          controller.isFavorite(product.id)
                              ? Constants.favFilledIcon
                              : Constants.favOutlinedIcon,
                          color: Colors.red,
                        ),
                      ),
                    ),
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
