import 'dart:math';

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
      else if(event is RefreshToUpdateFavorite){
        emit(GetAllPokemonInProgress());
        emit(GetAllPokemonSuccess(allPokemon: event.currentPokemonList));
      }
      else if(event is FilterByFavoritePokemon){
        final s = state;
        if(s is GetAllPokemonSuccess){
          emit(FilterByFavoritePokemonInProgress());
          final List<Pokemon> allFavoritePokemon = s.allPokemon.where((e) => e.isFavorite).toList();
          emit(FilterByFavoritePokemonSuccess(allFavoritePokemon: allFavoritePokemon));
        }
      }
      else if(event is RefreshOffline){
        emit(RefreshOfflineInProgress());
        emit(GetAllPokemonSuccess(allPokemon: allPokemon),);
      }
    });
  }

  void getAllPokemon(){
    add(GetAllPokemon());
  }

  void refreshOfflineData({required List<Pokemon> currentPokemonList,}){
    add(RefreshToUpdateFavorite(currentPokemonList: currentPokemonList,),);
  }

  void filterByFavoritePokemon(){
    add(FilterByFavoritePokemon());
  }

  void refreshOffline(){
    add(RefreshOffline());
  }
}
