import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pokemon_app/cores/blocs/localize/localize_bloc.dart';
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

  bool isFavorite = false;

  String searchKeyword = '';

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
                  height: 130,
                  child: Center(
                    child: BlocBuilder<LocalizeBloc, LocalizeState>(
                      builder: (context, state) {
                        String locale = 'en';
                        if(state is ChangeLocaleSuccess){
                          locale = state.locale;
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text(AppLocalizations.of(context)!.english,),
                              onTap: (){
                                BlocProvider.of<LocalizeBloc>(context).changeLocale(locale: 'en');
                              },
                              leading: SizedBox(
                                height: double.infinity,
                                width: 30,
                                child: Image.asset('assets/united-states.png'),
                              ),
                              selectedTileColor: Colors.blue,
                              selected: locale == 'en',
                              selectedColor: Colors.white,
                            ),
                            ListTile(
                              title: Text(AppLocalizations.of(context)!.khmer,),
                              onTap: (){
                                BlocProvider.of<LocalizeBloc>(context).changeLocale(locale: 'km');
                              },
                              leading: SizedBox(
                                height: double.infinity,
                                width: 30,
                                child: Image.asset('assets/cambodia.png'),
                              ),
                              selectedTileColor: Colors.blue,
                              selected: locale == 'km',
                              selectedColor: Colors.white,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }, 
          icon: const Icon(Icons.language,),),
          const ToggleThemeModeIconButton(),
        ],
        leadingWidth: 50,
        leading: Padding(
          padding: const EdgeInsets.only(left: 14.0,),
          child: Image.asset('assets/pokemon.png',),
        ),
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
                        onTap: () {
                          late final Pokemon evolvedFromPokemon;
                          try{
                            evolvedFromPokemon = state.allPokemon.where((element) => element.id == eachPokemon.evolvedFrom).first;
                          }catch(ex){
                            evolvedFromPokemon = eachPokemon;
                          }
                          final List<Pokemon> evolutionsFromPokemon = state.allPokemon.where((e) => eachPokemon.evolutions.contains(e.id)).toList();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PokemonDetailPage(selectedPokemon: eachPokemon, evolvedFromPokemon: evolvedFromPokemon, evolutionsFromPokemon: evolutionsFromPokemon),),);
                        },
                      );
                    },
                  );
                }
                else if(state is FilterByFavoritePokemonSuccess){
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                        childAspectRatio: 0.68
                    ),
                    itemCount: state.allFavoritePokemon.length,
                    itemBuilder: (context, index) {
                      final Pokemon eachPokemon = state.allFavoritePokemon[index];
                      return PokemonCard(
                        pokemon: eachPokemon,
                        onFavoriteIconTap: (isFavorite){
                          BlocProvider.of<AddToFavoriteBloc>(context).addToFavorite(selectedPokemonId: eachPokemon.id, isFavorite: isFavorite);
                        },
                        onTap: () {
                          late final Pokemon evolvedFromPokemon;
                          try{
                            evolvedFromPokemon = state.allPokemon.where((element) => element.id == eachPokemon.evolvedFrom).first;
                          }catch(ex){
                            evolvedFromPokemon = eachPokemon;
                          }
                          final List<Pokemon> evolutionsFromPokemon = state.allPokemon.where((e) => eachPokemon.evolutions.contains(e.id)).toList();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PokemonDetailPage(selectedPokemon: eachPokemon, evolvedFromPokemon: evolvedFromPokemon, evolutionsFromPokemon: evolutionsFromPokemon),),);
                        },
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
        onTap: (index) {
          if(index == 0){
            if(isFavorite){
              BlocProvider.of<GetAllPokemonBloc>(context).refreshOffline();
            }
            else{
              BlocProvider.of<GetAllPokemonBloc>(context).filterByFavoritePokemon();
            }
            setState(() {
              isFavorite = !isFavorite;
            });
          }
          else if(index == 1){
            _showSearchDialog();
          }
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(label: '', icon: isFavorite ? const Icon(Icons.favorite, color: Colors.red,) : const Icon(Icons.favorite_outline),),
          const BottomNavigationBarItem(label: '', icon: Icon(Icons.search),),
        ],
      ),
    );
  }

  Future<void> _showSearchDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.bottomCenter,
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: EdgeInsets.zero,
          content: TextFormField(
            initialValue: searchKeyword,
            autofocus: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              hintText: 'Search'
            ),
            onChanged: (value) {
              if(value == '' || value.isEmpty) return;
              searchKeyword = value;
              BlocProvider.of<GetAllPokemonBloc>(context).searchPokemon(pokemonName: value);
            },
          ),
        );
      },
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

