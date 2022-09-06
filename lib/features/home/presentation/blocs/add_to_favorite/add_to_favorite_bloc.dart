import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_app/features/home/domain/entities/pokemon.dart';
import 'package:pokemon_app/features/home/presentation/blocs/get_all_pokemon_bloc.dart';

part 'add_to_favorite_event.dart';
part 'add_to_favorite_state.dart';

class AddToFavoriteBloc extends Bloc<AddToFavoriteEvent, AddToFavoriteState> {
  final GetAllPokemonBloc _bloc;
  AddToFavoriteBloc(this._bloc) : super(AddToFavoriteInitial()) {
    on<AddToFavoriteEvent>((event, emit) {
      if(event is AddToFavorite){
          emit(AddToFavoriteInProgress());
          final s = _bloc.state;
          if(s is GetAllPokemonSuccess){
            List<Pokemon> ff = s.allPokemon;
            ff.where((element) => element.id == event.selectedPokemonId).first.isFavorite = event.isFavorite;
            _bloc.refreshOfflineData(currentPokemonList: ff);
          }
        emit(AddToFavoriteSuccess());
      }
    });
  }

  void addToFavorite({required String selectedPokemonId, required bool isFavorite}){
    add(AddToFavorite(selectedPokemonId: selectedPokemonId, isFavorite: isFavorite),);
  }
}
