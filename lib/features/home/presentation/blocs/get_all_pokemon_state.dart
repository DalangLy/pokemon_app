part of 'get_all_pokemon_bloc.dart';

abstract class GetAllPokemonState extends Equatable {
  const GetAllPokemonState();
}

class GetAllPokemonInitial extends GetAllPokemonState {
  @override
  List<Object> get props => [];
}

class GetAllPokemonInProgress extends GetAllPokemonState{
  @override
  List<Object?> get props => [];
}

class GetAllPokemonSuccess extends GetAllPokemonState{
  final List<Pokemon> allPokemon;

  const GetAllPokemonSuccess({required this.allPokemon,});

  @override
  List<Object?> get props => [];
}

class GetAllPokemonFailed extends GetAllPokemonState{
  final String message;

  const GetAllPokemonFailed({required this.message,});

  @override
  List<Object?> get props => [];
}

class FilterByFavoritePokemonInProgress extends GetAllPokemonState {
  @override
  List<Object> get props => [];
}

class FilterByFavoritePokemonSuccess extends GetAllPokemonState {
  final List<Pokemon> allFavoritePokemon;
  final List<Pokemon> allPokemon;
  const FilterByFavoritePokemonSuccess({required this.allFavoritePokemon, required this.allPokemon,});

  @override
  List<Object> get props => [];
}

class RefreshOfflineInProgress extends GetAllPokemonState {
  const RefreshOfflineInProgress();

  @override
  List<Object> get props => [];
}