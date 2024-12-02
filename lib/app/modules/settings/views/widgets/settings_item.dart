import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';
import '../../controllers/settings_controller.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isAccount;
  final bool isDark;
  final Widget? subtitle;
  final VoidCallback? onTap;

  const SettingsItem({
    Key? key,
    required this.title,
    required this.icon,
    this.isAccount = false,
    this.isDark = false,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: theme.textTheme.displayMedium?.copyWith(
          fontSize: 16.sp,
        ),
      ),
      subtitle: isAccount ? subtitle : null,
      leading: CircleAvatar(
        radius: isAccount ? 30.r : 25.r,
        backgroundColor: theme.primaryColor,
        child: SvgPicture.asset(icon, fit: BoxFit.none),
      ),
      trailing: isDark
          ? GetBuilder<SettingsController>(
        id: 'Theme',
        builder: (controller) => Switch(
          value: !controller.isLightTheme,
          onChanged: controller.changeTheme,
          activeColor: theme.primaryColor,
        ),
      )
          : Icon(Icons.arrow_forward_ios, color: theme.primaryColor),
    );
  }
}
