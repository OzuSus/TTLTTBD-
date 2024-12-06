import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
  final String name;
  final String imageName;

  const CategoryItem({Key? key, required this.name, required this.imageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/$imageName',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Text(
              name,
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20
              ),
            ),
          ),
        ],
      ),
    );
  }
}
