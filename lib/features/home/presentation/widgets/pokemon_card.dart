import 'package:flutter/material.dart';
import 'package:pokemon_app/features/home/domain/entities/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final void Function()? onTap;
  final void Function(bool isFavorite)? onFavoriteIconTap;
  const PokemonCard({Key? key, required this.pokemon, this.onTap, this.onFavoriteIconTap,}) : super(key: key);

  static const double _imageHeight = 160.0;
  @override
  Widget build(BuildContext context) {

    final String uniquePokemonImageTag = 'pokemonImage${pokemon.id}';

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 5.0, right: 5.0, bottom: 5.0,),
              child: Column(
                children: [
                  Hero(
                    tag: uniquePokemonImageTag,
                    child: Image(
                      height: _imageHeight,
                      image: NetworkImage(pokemon.imageUrl),loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return SizedBox(
                          height: _imageHeight,
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
                  Text(pokemon.name, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis,),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: pokemon.typeOfPokemon.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Chip(label: Text(pokemon.typeOfPokemon[index]),),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Chip(
                backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.2),
                label: Text(pokemon.id, style: Theme.of(context).textTheme.bodySmall,),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: FavoriteIconButton(
                onTap: onFavoriteIconTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteIconButton extends StatefulWidget {
  final void Function(bool isFavoriteSelected)? onTap;
  const FavoriteIconButton({Key? key, this.onTap,}) : super(key: key);

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {

  bool _isFavoriteSelected = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isFavoriteSelected ? const Icon(Icons.favorite, color: Colors.red,) : const Icon(Icons.favorite_outline),
      onPressed: (){
        setState(() {
          _isFavoriteSelected = !_isFavoriteSelected;
        });
        if(widget.onTap != null) return;
        widget.onTap!(_isFavoriteSelected);
      },
    );
  }
}

