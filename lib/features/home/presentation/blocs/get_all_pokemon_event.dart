part of 'get_all_pokemon_bloc.dart';

abstract class GetAllPokemonEvent extends Equatable {
  const GetAllPokemonEvent();
}

class GetAllPokemon extends GetAllPokemonEvent{
  @override
  List<Object?> get props => [];
}

class FilterByFavoritePokemon extends GetAllPokemonEvent {
  @override
  List<Object> get props => [];
}

class RefreshOffline extends GetAllPokemonEvent {
  @override
  List<Object> get props => [];
}

class SearchPokemon extends GetAllPokemonEvent {
  final String pokemonName;
  const SearchPokemon({required this.pokemonName});

  @override
  List<Object> get props => [];
}