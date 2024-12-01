import 'package:get/get.dart';
import 'package:pokedex/routes/routes_constants.dart';
import 'package:pokedex/screens/detail/detail_view.dart';
import 'package:pokedex/screens/home/home_view.dart';

class AppRoutes {
  static const String initial = Routes.home;

  static final List<GetPage> pages = [
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.detail,
      page: () => const DetailView(),
      transition: Transition.rightToLeft,
    ),
  ];
}
