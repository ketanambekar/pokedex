import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/routes/routes_constants.dart';
import 'package:pokedex/theme/app_colors.dart';
import 'package:pokedex/theme/app_text_style.dart';
import 'package:pokedex/utils/app_utils.dart';

class PokemonCardWidget extends StatelessWidget {
  final List<dynamic> pokemonList;

  const PokemonCardWidget({super.key, required this.pokemonList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: (pokemonList.length / 3).ceil(),
      itemBuilder: (context, rowIndex) {
        int startIndex = rowIndex * 3;
        List<dynamic> rowPokemons = pokemonList.sublist(
          startIndex,
          (startIndex + 3) > pokemonList.length
              ? pokemonList.length
              : startIndex + 3,
        );

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: rowPokemons.map((pokemon) {
              return PokemonCard(pokemon: pokemon);
            }).toList(),
          ),
        );
      },
    );
  }
}

class PokemonCard extends StatelessWidget {
  final dynamic pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final imageUrl = pokemon['image'] ??
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png'; // Fallback URL if no image is found

    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.detail, arguments: pokemon);
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 24),
                child: Text(
                  AppUtils.capitalizeFirstLetter(pokemon['name']),
                  textAlign: TextAlign.center, // Center the name
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.only(bottom: 20, top: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                  margin: const EdgeInsets.only(bottom: 10, right: 10,top: 10),
                  child: Text("#${pokemon['id']}",style: AppTextStyle.caption,)),
            )
          ],
        ),
      ),
    );
  }
}
