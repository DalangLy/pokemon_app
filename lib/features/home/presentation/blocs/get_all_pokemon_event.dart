part of 'get_all_pokemon_bloc.dart';

abstract class GetAllPokemonEvent extends Equatable {
  const GetAllPokemonEvent();
}

class GetAllPokemon extends GetAllPokemonEvent{
  @override
  List<Object?> get props => [];
}
