import 'package:get/get.dart';
import 'package:pokedex/services/api_service.dart';
import 'package:pokedex/constants/api_constants.dart';

class HomeController extends GetxController {
  var pokemonList = <dynamic>[].obs;
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
      final response = await Get.find<ApiService>().get(ApiConstants.pokemon, queryParameters: {'limit': 25});
      if (response != null && response['results'] != null) {
        pokemonList.value = response['results'];
      } else {
        errorMessage.value = "No Pokémon found";
      }
    } catch (e) {
      errorMessage.value = "Failed to fetch Pokémon: $e";
    } finally {
      isLoading(false);
    }
  }


}
