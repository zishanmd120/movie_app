import 'package:get/get.dart';
import 'package:movie_app_sheba_xyz/modules/home/binding/home_binding.dart';
import 'package:movie_app_sheba_xyz/modules/home/views/home_screen.dart';
import 'package:movie_app_sheba_xyz/modules/home/views/movie_details_screen.dart';

import 'app_routes.dart';

class AppPages{

  static String INITIAL = AppRoutes.homeScreen;

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.detailScreen,
      page: () => const MovieDetailsScreen(),
      binding: HomeBinding(),
    ),
  ];

}