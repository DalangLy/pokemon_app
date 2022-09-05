import 'package:flutter/material.dart';
import 'package:pokemon_app/features/home/domain/entities/pokemon.dart';

class PokemonDetailPage extends StatelessWidget {
  final Pokemon selectedPokemon;
  const PokemonDetailPage({Key? key, required this.selectedPokemon,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final String uniquePokemonImageTag = 'pokemonImage${selectedPokemon.id}';

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPokemon.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Hero(
                    tag: uniquePokemonImageTag,
                    child: Image(
                      image: NetworkImage(selectedPokemon.imageUrl),loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Text(selectedPokemon.name, style: Theme.of(context).textTheme.headline3,),
                  Text(selectedPokemon.height, style: Theme.of(context).textTheme.headline3,),
                  Text(selectedPokemon.category, style: Theme.of(context).textTheme.headline3,),
                  Text(selectedPokemon.weight, style: Theme.of(context).textTheme.headline3,),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedPokemon.typeOfPokemon.length,
                      itemBuilder: (context, index) {
                        return Chip(label: Text(selectedPokemon.typeOfPokemon[index],),);
                      },
                    ),
                  ),
                  Text(selectedPokemon.speed.toString(), style: Theme.of(context).textTheme.headline3,),
                  Text(selectedPokemon.hp.toString(), style: Theme.of(context).textTheme.headline3,),
                  Text(selectedPokemon.attack.toString(), style: Theme.of(context).textTheme.headline3,),
                  Text(selectedPokemon.defense.toString(), style: Theme.of(context).textTheme.headline3,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
