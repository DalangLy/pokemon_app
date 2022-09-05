import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokemon_app/features/home/data/data_sources/pokemon_remote_data_source_interface.dart';
import 'package:pokemon_app/features/home/data/models/pokemon_model.dart';

class PokemonRemoteDataSourceUsingDio implements PokemonRemoteDataSourceInterface{

  final Dio _dio;

  PokemonRemoteDataSourceUsingDio(this._dio);

  @override
  Future<List<PokemonModel>> get() async{
    try{
      final Response<dynamic> response = await _dio.get('https://gist.githubusercontent.com/hungps/0bfdd96d3ab9ee20c2e572e47c6834c7/raw/pokemons.json');
      if(response.statusCode == 200){
        final List<dynamic> parsed = jsonDecode(response.data);
        return parsed.map<PokemonModel>((eachJson) => PokemonModel.fromMap(eachJson)).toList();
      }
      throw Exception('Something Went Wrong While Getting All Pokemon!');
    }catch(ex){
      throw Exception('Can\'t Get All Pokemon!');
    }
  }

}