import 'package:ecommerce_app/app/modules/account/bindings/account_binding.dart';
import 'package:ecommerce_app/app/modules/account/views/account_view.dart';
import 'package:ecommerce_app/app/modules/categories/bindings/categories_binding.dart';
import 'package:ecommerce_app/app/modules/categories/views/categories_view.dart';
import 'package:ecommerce_app/app/modules/category_manage/bindings/category_manage_binding.dart';
import 'package:ecommerce_app/app/modules/category_manage/controllers/category_manage_controller.dart';
import 'package:ecommerce_app/app/modules/category_manage/views/category_manage_view.dart';
import 'package:ecommerce_app/app/modules/login/bindings/login_binding.dart';
import 'package:ecommerce_app/app/modules/login/views/login_view.dart';
import 'package:ecommerce_app/app/modules/product_manage/bindings/product_manage_binding.dart';
import 'package:ecommerce_app/app/modules/product_manage/views/Create_Product/bindings/create_product_binding.dart';
import 'package:ecommerce_app/app/modules/product_manage/views/Create_Product/views/create_product_view.dart';
import 'package:ecommerce_app/app/modules/product_manage/views/Edit_Product/bindings/edit_product_binding.dart';
import 'package:ecommerce_app/app/modules/product_manage/views/Edit_Product/views/edit_product_view.dart';
import 'package:ecommerce_app/app/modules/product_manage/views/product_manage_view.dart';
import 'package:ecommerce_app/app/modules/product_types/bindings/productTypesBinding.dart';
import 'package:ecommerce_app/app/modules/product_types/views/productTypes_view.dart';
import 'package:ecommerce_app/app/modules/register/bindings/register_bindings.dart';
import 'package:ecommerce_app/app/modules/register/views/register_view.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/app/modules/order_manage/views/order_manage_view.dart';
import 'package:ecommerce_app/app/modules/order_manage/bindings/order_manage_binding.dart';

import '../modules/base/bindings/base_binding.dart';
import '../modules/base/views/base_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/favorites/bindings/favorites_binding.dart';
import '../modules/favorites/views/favorites_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/product_details/bindings/product_details_binding.dart';
import '../modules/product_details/views/product_details_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/manage/bindings/manage_binding.dart';
import '../modules/manage/views/manage_view.dart';
import '../modules/user_manage/bindings/user_manage_binding.dart';
import '../modules/user_manage/views/user_manage_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.BASE,
      page: () => const BaseView(),
      binding: BaseBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITES,
      page: () => const FavoritesView(),
      binding: FavoritesBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => const CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS,
      page: () => const ProductDetailsView(),
      binding: ProductDetailsBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: _Paths.MANAGE,
      page: () => const ManageView(),
      binding: ManageBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => const AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_MANAGE,
      page: () => const CategoryManageView(),
      binding: CategoryManageBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_TYPES,
      page: () => const ProducttypesView(),
      binding: ProductTypesBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_MANAGE,
      page: () => const ProductManageView(),
      binding: ProductManageBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_EDIT,
      page: () => const EditProductView(),
      binding: EditProductBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_CREATE,
      page: () => const CreateProductView(),
      binding: CreateProductBinding(),
    ),
    GetPage(
      name: _Paths.USER_MANAGE,
      page: () => const UserManageView(),
      binding: UserManageBinding(),
    ),
      GetPage(
      name: _Paths.ORDER_MANAGE,
      page: () => const OrderManageView(),
      binding: OrderManageBinding(),
     ),
  ];
}
