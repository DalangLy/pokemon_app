part of 'get_all_pokemon_bloc.dart';

abstract class GetAllPokemonEvent extends Equatable {
  const GetAllPokemonEvent();
}

class GetAllPokemon extends GetAllPokemonEvent{
  @override
  List<Object?> get props => [];
}

class RefreshToUpdateFavorite extends GetAllPokemonEvent {

  final List<Pokemon> currentPokemonList;

  const RefreshToUpdateFavorite({required this.currentPokemonList,});

  @override
  List<Object> get props => [];
}

class FilterByFavoritePokemon extends GetAllPokemonEvent {
  @override
  List<Object> get props => [];
}

class RefreshOffline extends GetAllPokemonEvent {
  @override
  List<Object> get props => [];
}