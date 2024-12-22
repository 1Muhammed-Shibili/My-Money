import 'package:get/get.dart';
import 'package:my_money/controller/notification_controller.dart';

class SplashScreenController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    requestNotificationPermission();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed('/home');
    });
  }
}
