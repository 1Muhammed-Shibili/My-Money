import 'package:get/get.dart';
import 'package:my_money/screens/home%20screen/home_screen.dart';
import 'package:my_money/screens/splash%20screen/splash_screen.dart';
import 'package:my_money/screens/summary%20screen/summary_screen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const home = '/home';
  static const summary = '/summary';

  static final routes = [
    GetPage(name: '/splash', page: () => const SplashScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
    GetPage(name: '/summary', page: () => SummaryScreen()),
    // GetPage(name: '/summary', page: () => ),
  ];
}
