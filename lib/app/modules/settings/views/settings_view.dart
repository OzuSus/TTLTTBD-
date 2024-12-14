import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../components/screen_title.dart';
import '../controllers/settings_controller.dart';
import 'widgets/settings_item.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(
              title: 'Settings',
              dividerEndIndent: 230,
            ),
            20.verticalSpace,
            Text(
              'Account',
              style: theme.textTheme.displayMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            20.verticalSpace,
            GetBuilder<SettingsController>(
              id: 'User',
              builder: (controller) {
                final user = controller.currentUser;
                return Column(
                  children: [
                    SettingsItem(
                      title: user?['username'] ?? 'Username',
                      subtitle: user != null
                          ? Text(
                        user['email'] ?? '',
                        style: theme.textTheme.displaySmall,
                      )
                          : null,
                      icon: Constants.userIcon,
                      isAccount: true,
                    ),
                    if (user != null && user['role'] == true) ...[
                      25.verticalSpace,
                      SettingsItem(
                        title: 'Manage',
                        icon: Constants.clipboardIcon,
                        onTap: () => controller.navigateToManage(),
                      ),
                    ],
                  ],
                );
              },
            ),
            // 25.verticalSpace,
            // const SettingsItem(
            //   title: 'Manage',
            //   icon: Constants.languageIcon,
            // ),

            30.verticalSpace,
            Text(
              'Settings',
              style: theme.textTheme.displayMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            // 20.verticalSpace,
            // const SettingsItem(
            //   title: 'Dark Mode',
            //   icon: Constants.themeIcon,
            //   isDark: true,
            // ),
            25.verticalSpace,
            const SettingsItem(
              title: 'Language',
              icon: Constants.languageIcon,
            ),
            25.verticalSpace,
            const SettingsItem(
              title: 'Help',
              icon: Constants.helpIcon,
            ),
            25.verticalSpace,
            // Đăng xuất
            SettingsItem(
              title: 'Sign Out',
              icon: Constants.logoutIcon,
              onTap: () => controller.logout(),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
