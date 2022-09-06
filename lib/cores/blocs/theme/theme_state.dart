part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  @override
  List<Object> get props => [];
}

class ChangeThemeInProgress extends ThemeState {
  @override
  List<Object> get props => [];
}

class ChangeThemeSuccess extends ThemeState {

  final ThemeMode themeMode;

  const ChangeThemeSuccess({required this.themeMode,});

  @override
  List<Object> get props => [];
}

class ChangeThemeFailed extends ThemeState {
  @override
  List<Object> get props => [];
}