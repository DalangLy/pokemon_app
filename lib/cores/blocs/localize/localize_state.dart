part of 'localize_bloc.dart';

abstract class LocalizeState extends Equatable {
  const LocalizeState();
}

class LocalizeInitial extends LocalizeState {
  @override
  List<Object> get props => [];
}

class ChangeLocaleInProgress extends LocalizeState {

  @override
  List<Object> get props => [];
}

class ChangeLocaleSuccess extends LocalizeState {
  final String locale;
  const ChangeLocaleSuccess({required this.locale,});
  @override
  List<Object> get props => [];
}

class ChangeLocaleFailed extends LocalizeState {
  @override
  List<Object> get props => [];
}