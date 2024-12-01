import 'package:get/get.dart';
import 'package:pokedex/services/api_service.dart';
import 'package:pokedex/constants/api_constants.dart';
import 'package:pokedex/utils/app_utils.dart';

class HomeController extends GetxController {
  var pokemonList = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPokemonList();
  }

  Future<void> fetchPokemonList() async {
    try {
      isLoading(true);
      final response = await Get.find<ApiService>()
          .get(ApiConstants.pokemon, queryParameters: {'limit': 27});

      if (response != null && response['results'] != null) {
        pokemonList.clear();
        for (var pokemon in response['results']) {
          final pokemonDetails = await fetchPokemonDetails(pokemon['url']);
          pokemonList.add({
            'name': pokemon['name'],
            'image': pokemonDetails['sprites']['front_default'] ??
                '',
            'id': AppUtils.getIdFromUrl(pokemon['url'])
          });
        }
      } else {
        errorMessage.value = "No Pokémon found";
      }
    } catch (e) {
      errorMessage.value = "Failed to fetch Pokémon: $e";
    } finally {
      isLoading(false);
    }
  }

  Future<Map<String, dynamic>> fetchPokemonDetails(String url) async {
    final response = await Get.find<ApiService>().get(url);
    return response;
  }
}
