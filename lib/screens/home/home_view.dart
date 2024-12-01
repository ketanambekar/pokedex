import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/constants/app_assets.dart';
import 'package:pokedex/screens/home/home_controller.dart';
import 'package:pokedex/screens/home/widgets/pokemon_card.dart';
import 'package:pokedex/theme/app_colors.dart';
import 'package:pokedex/theme/app_text_style.dart';
import 'package:pokedex/widgets/app_image.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());

    return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.all(12),
            child: AppImage(assetPath: AppAssets.pokeBall),
          ),
          title: Text(
            'Pokédex',
            style: AppTextStyle.headline.copyWith(color: AppColors.white),
          ),
          backgroundColor: AppColors.primary,
        ),
        body: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppColors.white,
          ),
          margin: const EdgeInsets.all(4),
          child: Obx(() {
            if (homeController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (homeController.errorMessage.isNotEmpty) {
              return Center(child: Text(homeController.errorMessage.value));
            }

            return PokemonCardWidget(pokemonList: homeController.pokemonList);
          }),
        ));
  }
}
