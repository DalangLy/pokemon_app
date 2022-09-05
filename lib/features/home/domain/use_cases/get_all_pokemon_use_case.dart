import 'package:pokemon_app/features/home/domain/entities/pokemon.dart';
import 'package:pokemon_app/features/home/domain/repositories/pokemon_repository_interface.dart';

class GetAllPokemonUseCase{
  final PokemonRepositoryInterface _repository;

  GetAllPokemonUseCase(this._repository);

  Future<List<Pokemon>> call(){
    return _repository.get();
  }
}