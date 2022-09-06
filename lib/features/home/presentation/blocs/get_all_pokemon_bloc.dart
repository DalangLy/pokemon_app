import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_app/features/home/domain/entities/pokemon.dart';
import 'package:pokemon_app/features/home/domain/use_cases/get_all_pokemon_use_case.dart';

part 'get_all_pokemon_event.dart';
part 'get_all_pokemon_state.dart';

class GetAllPokemonBloc extends Bloc<GetAllPokemonEvent, GetAllPokemonState> {

  final GetAllPokemonUseCase _useCase;

  late final List<Pokemon> allPokemon;

  GetAllPokemonBloc(this._useCase) : super(GetAllPokemonInitial()) {
    on<GetAllPokemonEvent>((event, emit) async{
      if(event is GetAllPokemon){
        emit(GetAllPokemonInProgress());
        try{
          allPokemon = await _useCase();
          emit(GetAllPokemonSuccess(allPokemon: allPokemon),);
        }catch(ex){
          emit(const GetAllPokemonFailed(message: 'Failed Message'),);
        }
      }
      else if(event is FilterByFavoritePokemon){
        emit(FilterByFavoritePokemonInProgress());
        final List<Pokemon> allFavoritePokemon = allPokemon.where((e) => e.isFavorite).toList();
        emit(FilterByFavoritePokemonSuccess(allFavoritePokemon: allFavoritePokemon, allPokemon: allPokemon,),);
      }
      else if(event is RefreshOffline){
        emit(const RefreshOfflineInProgress());
        emit(GetAllPokemonSuccess(allPokemon: allPokemon),);
      }
      else if(event is SearchPokemon){
        emit(const RefreshOfflineInProgress());
        final List<Pokemon> foundPokemon = allPokemon.where((element) => element.name.toLowerCase().contains(event.pokemonName.toLowerCase())).toList();
        emit(GetAllPokemonSuccess(allPokemon: foundPokemon),);
      }
    });
  }

  void getAllPokemon(){
    add(GetAllPokemon());
  }

  void filterByFavoritePokemon(){
    add(FilterByFavoritePokemon());
  }

  void refreshOffline(){
    add(RefreshOffline());
  }

  void searchPokemon({required String pokemonName,}){
    add(SearchPokemon(pokemonName: pokemonName),);
  }
}
