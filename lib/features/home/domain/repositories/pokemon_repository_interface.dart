import 'package:pokemon_app/features/home/domain/entities/pokemon.dart';

abstract class PokemonRepositoryInterface{
  Future<List<Pokemon>> get();
}