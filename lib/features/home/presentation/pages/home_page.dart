import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pokemon_app/cores/blocs/theme/theme_bloc.dart';
import 'package:pokemon_app/features/home/domain/entities/pokemon.dart';
import 'package:pokemon_app/features/home/presentation/blocs/add_to_favorite/add_to_favorite_bloc.dart';
import 'package:pokemon_app/features/home/presentation/blocs/get_all_pokemon_bloc.dart';
import 'package:pokemon_app/features/home/presentation/pages/pokemon_detail_page.dart';
import 'package:pokemon_app/features/home/presentation/widgets/pokemon_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    BlocProvider.of<GetAllPokemonBloc>(context).getAllPokemon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title,),
        actions: [
          IconButton(onPressed: (){
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: const Text('English'),
                          onTap: (){},
                        ),
                        ListTile(
                          title: const Text('Khmer'),
                          onTap: (){},
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }, icon: const Icon(Icons.language,),),
          const ToggleThemeModeIconButton(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: BlocBuilder<GetAllPokemonBloc, GetAllPokemonState>(
              builder: (context, state) {
                if(state is GetAllPokemonSuccess){
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      childAspectRatio: 0.68
                    ),
                    itemCount: state.allPokemon.length,
                    itemBuilder: (context, index) {
                      final Pokemon eachPokemon = state.allPokemon[index];
                      return PokemonCard(
                        pokemon: eachPokemon,
                        onFavoriteIconTap: (isFavorite){
                          BlocProvider.of<AddToFavoriteBloc>(context).addToFavorite(selectedPokemonId: eachPokemon.id, isFavorite: isFavorite);
                        },
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => PokemonDetailPage(selectedPokemon: eachPokemon,),),),
                      );
                    },
                  );
                }
                return Lottie.asset('assets/66414-processing-loading.json', width: 100);
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {

        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(label: '', icon: Icon(Icons.favorite, color: Colors.red,),),
          BottomNavigationBarItem(label: '', icon: Icon(Icons.search),),
        ],
      ),
    );
  }
}

class ToggleThemeModeIconButton extends StatefulWidget {
  const ToggleThemeModeIconButton({Key? key}) : super(key: key);

  @override
  State<ToggleThemeModeIconButton> createState() => _ToggleThemeModeIconButtonState();
}

class _ToggleThemeModeIconButtonState extends State<ToggleThemeModeIconButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        ThemeMode themeMode = ThemeMode.light;
        if(state is ChangeThemeSuccess){
          themeMode = state.themeMode;
        }
        return IconButton(onPressed: (){
          BlocProvider.of<ThemeBloc>(context).changeTheme(themeMode: themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,);
        }, icon: Icon(themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,),);
      },
    );
  }
}

