import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pokemon_app/features/home/domain/entities/pokemon.dart';
import 'package:pokemon_app/features/home/presentation/blocs/add_to_favorite/add_to_favorite_bloc.dart';
import 'package:pokemon_app/features/home/presentation/widgets/pokemon_card.dart';

class PokemonDetailPage extends StatelessWidget {
  final Pokemon selectedPokemon;
  final Pokemon evolvedFromPokemon;
  final List<Pokemon> evolutionsFromPokemon;
  const PokemonDetailPage({Key? key, required this.selectedPokemon, required this.evolvedFromPokemon, required this.evolutionsFromPokemon,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPokemon.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FullSizedImagePreview(pokemon: selectedPokemon,),
                Text(selectedPokemon.name, style: Theme.of(context).textTheme.headline3,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Type'),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedPokemon.typeOfPokemon.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Chip(
                              label: Text(selectedPokemon.typeOfPokemon[index],),),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: PageView(
                    children: [
                      Card(
                        child: Column(
                          children: [
                            BarDetail(label: 'Speed', value: selectedPokemon.speed, iconPath: 'assets/stopwatch.png',),
                            BarDetail(label: 'HP', value: selectedPokemon.hp, iconPath: 'assets/health.png',),
                            BarDetail(label: 'Attack', value: selectedPokemon.attack, iconPath: 'assets/explosion.png',),
                            BarDetail(label: 'Defense', value: selectedPokemon.defense, iconPath: 'assets/weapons.png',),
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          children: [
                            BarDetail(label: 'Special Attack', value: selectedPokemon.specialAttack, iconPath: 'assets/stopwatch.png',),
                            BarDetail(label: 'Special Defense', value: selectedPokemon.specialDefense, iconPath: 'assets/health.png',),
                            BarDetail(label: 'Total', value: selectedPokemon.total, iconPath: 'assets/explosion.png',),
                            BarDetail(label: 'Base Exp', value: int.parse(selectedPokemon.baseExp), iconPath: 'assets/weapons.png',),
                          ],
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Description', style: Theme.of(context).textTheme.headline6,),
                              const Divider(),
                              Text(selectedPokemon.xDescription),
                              Text(selectedPokemon.yDescription),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Evolved From', style: Theme.of(context).textTheme.headline6,),
                              const Divider(),
                              Expanded(
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Image(image: NetworkImage(evolvedFromPokemon.imageUrl),),
                                  ),
                                ),
                              ),
                              Text(evolvedFromPokemon.name,)
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Gender', style: Theme.of(context).textTheme.headline6,),
                              const Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Center(
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Image.asset('assets/dog-male.png', width: 120,)
                                          ),
                                        ),
                                        const Text('Male Percentage'),
                                        Text(evolvedFromPokemon.malePercentage,)
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Center(
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Image.asset('assets/dog-female.png', width: 120,)
                                          ),
                                        ),
                                        const Text('Female Percentage'),
                                        Text(evolvedFromPokemon.femalePercentage,)
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Egg Groups', style: Theme.of(context).textTheme.headline6,),
                              const Divider(),
                              Text(selectedPokemon.eggGroups,),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Weaknesses', style: Theme.of(context).textTheme.headline6,),
                              const Divider(),
                              ...selectedPokemon.weaknesses.map((e) => Text(e),),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Abilities', style: Theme.of(context).textTheme.headline6,),
                              const Divider(),
                              ...selectedPokemon.abilities.map((e) => Text(e),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                //evolution
                Text('Evolutions', style: Theme.of(context).textTheme.headline6,),
                ...evolutionsFromPokemon.map((e) {
                  if(evolutionsFromPokemon.indexOf(e) == (evolutionsFromPokemon.length-1)){
                    return Center(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      child: Column(
                        children: [
                          Image.network(e.imageUrl),
                          Text(e.name),
                        ],
                      ),
                    ),
                    );
                  }
                  else{
                    return Center(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Image.network(e.imageUrl),
                          Text(e.name),
                          const SizedBox(height: 20,),
                          const Icon(Icons.arrow_downward)
                        ],
                      ),
                    ),
                    );
                  }
                },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FullSizedImagePreview extends StatelessWidget {
  final Pokemon pokemon;
  const FullSizedImagePreview({Key? key, required this.pokemon,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String uniquePokemonImageTag = 'pokemonImage${pokemon.id}';

    return Card(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 5.0, right: 5.0, bottom: 5.0,),
            child: SizedBox(
              height: 300,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 3,
                    child: Hero(
                      tag: uniquePokemonImageTag,
                      child: Image(
                        image: NetworkImage(pokemon.imageUrl),loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return SizedBox(
                          child: Center(
                            child: Lottie.asset('assets/68374-animation-image.json'),
                          ),
                        );
                      },
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 50,
                      height: 170,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        verticalDirection: VerticalDirection.down,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Image(image: AssetImage('assets/height.png'), width: 60,),
                              Text(pokemon.height)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Image(image: AssetImage('assets/kilogram.png'), width: 40,),
                              Text(pokemon.weight)
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 5.0,
            left: 5.0,
            child: Chip(label: Text(pokemon.category), avatar: const Icon(Icons.category),),
          ),
          Positioned(
            top: 5.0,
            right: 5.0,
            child: FavoriteIconButton(
              onTap: (isFavorite){
                BlocProvider.of<AddToFavoriteBloc>(context).addToFavorite(selectedPokemonId: pokemon.id, isFavorite: isFavorite);
              },
              isFavorite: pokemon.isFavorite,
            )
          ),
        ],
      ),
    );
  }
}


class BarDetail extends StatelessWidget {
  final String label;
  final int value;
  final String iconPath;
  const BarDetail({Key? key, required this.label, required this.value, required this.iconPath,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          top: 0,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 5.0, right: 15.0),
            child: Text('${value.toString()}/100', style: Theme.of(context).textTheme.bodySmall,),
          ),
        ),
        ListTile(
          title: Text(label),
          subtitle: PowerBar(value: value / 100,),
          leading: SizedBox(
            height: double.infinity,
            child: Image(image: AssetImage(iconPath), width: 40.0,),
          ),
        ),
      ],
    );
  }
}


class PowerBar extends StatefulWidget {
  final double value;
  const PowerBar({Key? key, required this.value}) : super(key: key);

  @override
  State<PowerBar> createState() => _PowerBarState();
}

class _PowerBarState extends State<PowerBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: widget.value,
    );
  }
}

