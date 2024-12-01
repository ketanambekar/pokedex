import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the Pokémon data passed from HomeView
    final pokemon = Get.arguments; // Fetching the data passed to the DetailView

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${pokemon['name']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'URL: ${pokemon['url']}',
              style: const TextStyle(fontSize: 16),
            ),
            // You can add more details of the Pokémon here like images or stats
            // For now, we are just showing the name and URL.
          ],
        ),
      ),
    );
  }
}
