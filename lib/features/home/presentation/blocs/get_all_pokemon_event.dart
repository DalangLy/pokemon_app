part of 'get_all_pokemon_bloc.dart';

abstract class GetAllPokemonEvent extends Equatable {
  const GetAllPokemonEvent();
}

class GetAllPokemon extends GetAllPokemonEvent{
  @override
  List<Object?> get props => [];
}

class RefreshOfflineData extends GetAllPokemonEvent {

  final List<Pokemon> currentPokemonList;

  const RefreshOfflineData({required this.currentPokemonList,});

  @override
  List<Object> get props => [];
}