import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/app/app_binding.dart';
import 'package:pokedex/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.pages,
      defaultTransition: Transition.fade,
    );
  }
}
