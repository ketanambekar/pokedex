import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/routes/routes_constants.dart';
import 'package:pokedex/screens/home/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bind the controller
    final homeController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: Obx(() {
        // Show a loading spinner if data is being fetched
        if (homeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show error message if there's an error
        if (homeController.errorMessage.isNotEmpty) {
          return Center(child: Text(homeController.errorMessage.value));
        }

        // Show list of Pokémon if fetched successfully
        return ListView.builder(
          itemCount: homeController.pokemonList.length,
          itemBuilder: (context, index) {
            final pokemon = homeController.pokemonList[index];
            return ListTile(
              title: Text(pokemon['name']),
              onTap: () {
                // Navigate to the DetailView and pass the selected Pokémon data
                Get.toNamed(Routes.detail, arguments: pokemon);
              },
            );
          },
        );
      }),
    );
  }
}
