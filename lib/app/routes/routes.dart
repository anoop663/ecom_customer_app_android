import 'package:ecommerce_app/app/modules/account/view/account_view.dart';
import 'package:ecommerce_app/app/modules/address_manage/view/address_list.dart';
import 'package:ecommerce_app/app/modules/address_manage/view/new_address.dart';
import 'package:ecommerce_app/app/modules/best_items/view/best_items_view.dart';
import 'package:ecommerce_app/app/modules/brands/view/brand_products.dart';
import 'package:ecommerce_app/app/modules/brands/view/brand_view.dart';
import 'package:ecommerce_app/app/modules/cart/binding/cart_binding.dart';
import 'package:ecommerce_app/app/modules/cart/view/cart_view.dart';
import 'package:ecommerce_app/app/modules/categories/view/categories_view.dart';
import 'package:ecommerce_app/app/modules/checkout/view/checkout_view.dart';
import 'package:ecommerce_app/app/modules/forgot_pass/view/forgot_pass.dart';
import 'package:ecommerce_app/app/modules/forgot_pass/view/setnew_pass.dart';
import 'package:ecommerce_app/app/modules/home/views/home.dart';
import 'package:ecommerce_app/app/modules/otp/views/otpverify.dart';
import 'package:ecommerce_app/app/modules/products/view/product_view.dart';
import 'package:ecommerce_app/app/modules/signin/views/signin.dart';
import 'package:ecommerce_app/app/modules/signup/views/signup.dart';
import 'package:ecommerce_app/app/modules/splash_screen/view/splash_view.dart';
import 'package:ecommerce_app/app/modules/wishlist/view/wishlist_view.dart';
import 'package:ecommerce_app/app/widgets/app_bottom_bar.dart';
import 'package:ecommerce_app/app/widgets/no_connection.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  static const String home = '/home';
  static const String signin = '/signin';
  static const String signup = '/signinup';
  static const String otp = '/otp';
  static const String bottombar = '/bottombar';
  static const String forgotpage = '/forgot';
  static const String setnewpass = '/set-new-pass';
  static const String splashscreen = '/splash-screen';
  static const String brandsscreen = '/brands-screen';
  static const String categoriespage = '/categories-page';
  static const String brandproducts = '/categories-brandproducts';
  static const String bestItems = '/best-items';
  static const String productdetails = '/product-details';
  static const String wishlist = '/wishlist';
  static const String cart = '/cart';
  static const String addressnew = '/address-new';
  static const String checkout = '/checkout';
  static const String account = '/account';
  static const String address = '/address';
  static const String noconnection = '/noconnection';


  static final List<GetPage> pages = [
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: signin, page: () => SigninPage()),
    GetPage(name: signup, page: () => SignupPage()),
    GetPage(name: otp, page: () => OtpPage()),
    GetPage(name: bottombar, page: () => AppBottomBar()),
    GetPage(name: forgotpage, page: () => ForgotPage()),
    GetPage(name: setnewpass, page: () => SetNewPassword()),
    GetPage(name: splashscreen, page: () => SpashScreen()),
    GetPage(name: brandsscreen, page: () => BrandPage()),
    GetPage(name: brandsscreen, page: () => CategoriesPage()),
    GetPage(name: brandproducts, page: () => BrandProducts()),
    GetPage(name: bestItems, page: () => BestItems()),
    GetPage(name: productdetails, page: () => ProductPage()),
    GetPage(name: wishlist, page: () => WishListView()),
    GetPage(name: Routes.cart, page: () => CartView(), binding: CartBinding()),
    GetPage(name: addressnew, page: () => CreateAddressView()),
    GetPage(name: checkout, page: () => CheckoutScreenView()),
    GetPage(name: account, page: () => AccountView()),
    GetPage(name: address, page: () => MyAddressListView()),
    GetPage(name: noconnection, page: () => NoConnection(),
    ),
  ];
}