part of 'add_to_favorite_bloc.dart';

abstract class AddToFavoriteEvent extends Equatable {
  const AddToFavoriteEvent();
}

class AddToFavorite extends AddToFavoriteEvent {
  final String selectedPokemonId;
  final bool isFavorite;
  const AddToFavorite({required this.selectedPokemonId, required this.isFavorite,});

  @override
  List<Object> get props => [];
}