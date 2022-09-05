import 'package:pokemon_app/features/home/data/models/pokemon_model.dart';

abstract class PokemonRemoteDataSourceInterface{
  Future<List<PokemonModel>> get();
}