import 'package:get/get.dart';
import 'package:my_money/screens/home%20screen/home_screen.dart';
import 'package:my_money/screens/splash%20screen/splash_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/splash', page: () => const SplashScreen()),
    GetPage(name: '/', page: () => HomeScreen()),
  ];
}
