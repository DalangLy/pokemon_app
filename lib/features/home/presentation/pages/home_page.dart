import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/features/home/domain/entities/pokemon.dart';
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
          IconButton(onPressed: (){}, icon: const Icon(Icons.dark_mode,),),
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
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => PokemonDetailPage(selectedPokemon: eachPokemon,),),),
                      );
                    },
                  );
                }
                return const Text('Loading...');
              },
            ),
          ),
        ),
      ),
    );
  }
}
