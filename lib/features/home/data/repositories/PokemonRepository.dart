import 'package:pokemon_app/features/home/data/data_sources/pokemon_remote_data_source_interface.dart';
import 'package:pokemon_app/features/home/domain/entities/pokemon.dart';
import 'package:pokemon_app/features/home/domain/repositories/pokemon_repository_interface.dart';

class PokemonRepository implements PokemonRepositoryInterface{

  final PokemonRemoteDataSourceInterface _remoteDataSource;

  PokemonRepository(this._remoteDataSource);

  @override
  Future<List<Pokemon>> get() {
    return _remoteDataSource.get();
  }
}