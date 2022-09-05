import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_app/features/home/domain/entities/pokemon.dart';
import 'package:pokemon_app/features/home/domain/use_cases/get_all_pokemon_use_case.dart';

part 'get_all_pokemon_event.dart';
part 'get_all_pokemon_state.dart';

class GetAllPokemonBloc extends Bloc<GetAllPokemonEvent, GetAllPokemonState> {
  final GetAllPokemonUseCase _useCase;
  GetAllPokemonBloc(this._useCase) : super(GetAllPokemonInitial()) {
    on<GetAllPokemonEvent>((event, emit) async{
      if(event is GetAllPokemon){
        emit(GetAllPokemonInProgress());
        try{
          final List<Pokemon> allPokemon = await _useCase();
          emit(GetAllPokemonSuccess(allPokemon: allPokemon),);
        }catch(ex){
          emit(const GetAllPokemonFailed(message: 'Failed Message'),);
        }
      }
    });
  }

  void getAllPokemon(){
    add(GetAllPokemon());
  }
}
