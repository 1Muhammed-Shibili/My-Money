import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_money/config/routes.dart';
import 'package:my_money/controller/main_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final mainController = Get.put(MainController());
  await mainController.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Money',
      initialRoute: '/splash',
      getPages: AppRoutes.routes,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}
