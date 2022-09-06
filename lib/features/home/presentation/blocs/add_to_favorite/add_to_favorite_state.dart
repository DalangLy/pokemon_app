part of 'add_to_favorite_bloc.dart';

abstract class AddToFavoriteState extends Equatable {
  const AddToFavoriteState();
}

class AddToFavoriteInitial extends AddToFavoriteState {
  @override
  List<Object> get props => [];
}

class AddToFavoriteInProgress extends AddToFavoriteState {
  @override
  List<Object> get props => [];
}

class AddToFavoriteSuccess extends AddToFavoriteState {
  @override
  List<Object> get props => [];
}

class AddToFavoriteFailed extends AddToFavoriteState {
  const AddToFavoriteFailed();

  @override
  List<Object> get props => [];
}