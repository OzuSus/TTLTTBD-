import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_button.dart';
import '../../../components/no_data.dart';
import '../../../components/screen_title.dart';
import '../controllers/cart_controller.dart';
import 'widgets/cart_item.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: GetBuilder<CartController>(
          builder: (_) => ListView(
            children: [
              30.verticalSpace,
              const ScreenTitle(
                title: 'Cart',
                dividerEndIndent: 280,
              ),
              20.verticalSpace,
              controller.products.isEmpty
                ? const NoData(text: 'Ko có sản phẩm nào trong giỏ hàng của bạn!')
                : ListView.builder(
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) => CartItem(
                      product: controller.products[index],
                    ).animate().fade().slideX(
                      duration: const Duration(milliseconds: 300),
                      begin: -1,
                      curve: Curves.easeInSine,
                    ),
                    shrinkWrap: true,
                    primary: false,
                  ),
              50.verticalSpace,
              Visibility(
                visible: controller.products.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thông tin giao hàng',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    15.verticalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Tên người nhận
                          Container(
                            padding: EdgeInsets.all(15.r),
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                              color:  Color(0xFFE3E3E3),
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.person, color: theme.primaryColor),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text(
                                    controller.user?.fullname ?? 'Loading...',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black26
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Số điện thoại
                          Container(
                            padding: EdgeInsets.all(15.r),
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                              color:  Color(0xFFE3E3E3),
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.email, color: theme.primaryColor),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text(
                                      controller.user?.email ?? 'Loading...',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black26
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Địa chỉ
                          Container(
                            padding: EdgeInsets.all(15.r),
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                              color:  Color(0xFFE3E3E3),
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.phone, color: theme.primaryColor),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text(
                                      controller.user?.phone ?? 'Loading...',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black26
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Email
                          Container(
                            padding: EdgeInsets.all(15.r),
                            decoration: BoxDecoration(
                              color:  Color(0xFFE3E3E3),
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.home, color: theme.primaryColor),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text(
                                      controller.user?.address ?? 'Loading...',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black26
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              40.verticalSpace,
              Visibility(
                visible: controller.products.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phương thức thanh toán',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    15.verticalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: GetBuilder<CartController>(
                        id: 'PaymentMethod',
                        builder: (controller) => Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(15.r),
                              margin: EdgeInsets.only(bottom: 10.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Radio<String>(
                                    value: 'COD',
                                    groupValue: controller.selectedPaymentMethod,
                                    onChanged: (value) =>
                                        controller.onPaymentMethodChanged(value!),
                                    activeColor: theme.primaryColor,
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      'Cash on Delivery (COD)',
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(15.r),
                              margin: EdgeInsets.only(bottom: 10.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Radio<String>(
                                        value: 'Banking',
                                        groupValue:
                                        controller.selectedPaymentMethod,
                                        onChanged: (value) =>
                                            controller.onPaymentMethodChanged(
                                                value!),
                                        activeColor: theme.primaryColor,
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Text(
                                          'Bank Transfer',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            fontSize: 18.sp, fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  if (controller.selectedPaymentMethod == 'Banking') ...[
                                    10.verticalSpace,
                                    Card(
                                      elevation: 6,
                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Thông tin thanh toán',
                                              style: theme.textTheme.titleLarge?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: theme.colorScheme.primary,
                                              ),
                                            ),
                                            15.verticalSpace,
                                            Divider(color: theme.dividerColor, thickness: 1),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Text(
                                                    'Tài khoản:',
                                                    style: theme.textTheme.bodyLarge?.copyWith(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.grey.shade600,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 6,
                                                  child: Text(
                                                    'PHUNG VAN DUOC',
                                                    style: theme.textTheme.bodyLarge?.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Text(
                                                    'Ngân hàng:',
                                                    style: theme.textTheme.bodyLarge?.copyWith(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.grey.shade600,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 6,
                                                  child: Text(
                                                    'Vietcombank',
                                                    style: theme.textTheme.bodyLarge?.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Text(
                                                    'Số tài khoản:',
                                                    style: theme.textTheme.bodyLarge?.copyWith(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.grey.shade600,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 6,
                                                  child: Text(
                                                    '1016444855',
                                                    style: theme.textTheme.bodyLarge?.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            10.verticalSpace,
                                            Text(
                                              'Nội dung chuyển khoản:',
                                              style: theme.textTheme.bodyLarge?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                            10.verticalSpace,
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(color: theme.colorScheme.primary, width: 1.2),
                                              ),
                                              child: GetBuilder<CartController>(
                                                id: 'EncodedBankingInfo',
                                                builder: (controller) => Text(
                                                  controller.encodedBankingInfo,
                                                  style: theme.textTheme.bodyLarge?.copyWith(
                                                    fontSize: 16,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(15.r),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Radio<String>(
                                        value: 'QRCode',
                                        groupValue:
                                        controller.selectedPaymentMethod,
                                        onChanged: (value) =>
                                            controller.onPaymentMethodChanged(
                                                value!),
                                        activeColor: theme.primaryColor,
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Text(
                                          'QR Code Payment',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            fontSize: 18.sp,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (controller.selectedPaymentMethod ==
                                      'QRCode') ...[
                                    10.verticalSpace,
                                    Card(
                                      elevation: 6,
                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child:
                                      GetBuilder<CartController>(
                                        id: 'QRCodeData',
                                        builder: (controller) => Center(
                                          child: QrImageView(
                                            data: controller.qrCodeData,
                                            size: 200.w,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              30.verticalSpace,
              Visibility(
                visible: controller.products.isNotEmpty,
                child: Row(
                  children: [
                    Container(
                      width: 65.w,
                      height: 65.h,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Constants.busIcon),
                          5.verticalSpace,
                          Text('FREE', style: theme.textTheme.displaySmall?.copyWith(
                            color: Colors.white,
                          )),
                        ],
                      ),
                    ),
                    20.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tổng:', style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 18.sp,
                        )),
                        10.verticalSpace,
                        GetBuilder<CartController>(
                          id: 'TotalPrice',
                          builder: (controller) => Text(
                            '\$${controller.total.toStringAsFixed(2)}',
                            style: theme.textTheme.displayLarge?.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: theme.primaryColor.withOpacity(0.5),
                              decorationThickness: 1,
                              color: Colors.transparent,
                              shadows: [
                                Shadow(
                                  color: theme.textTheme.displayLarge!.color!,
                                  offset: const Offset(0, -5),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ).animate().fade().slideX(
                  duration: const Duration(milliseconds: 300),
                  begin: -1,
                  curve: Curves.easeInSine,
                ),
              ),
              30.verticalSpace,
              Visibility(
                visible: controller.products.isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: CustomButton(
                    text: 'Đặt hàng ngay',
                    onPressed: () => controller.onPurchaseNowPressed(),
                    fontSize: 16.sp,
                    radius: 12.r,
                    verticalPadding: 12.h,
                    hasShadow: true,
                    shadowColor: theme.primaryColor,
                    shadowOpacity: 0.3,
                    shadowBlurRadius: 4,
                    shadowSpreadRadius: 0,
                  ).animate().fade().slideY(
                    duration: const Duration(milliseconds: 300),
                    begin: 1,
                    curve: Curves.easeInSine,
                  ),
                ),
              ),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
