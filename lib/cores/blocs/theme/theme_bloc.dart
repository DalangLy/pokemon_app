import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ThemeEvent>((event, emit) {
      if(event is ChangeTheme){
        emit(ChangeThemeInProgress());
        emit(ChangeThemeSuccess(themeMode: event.themeMode,),);
      }
    });
  }

  void changeTheme({required ThemeMode themeMode,}){
    add(ChangeTheme(themeMode: themeMode,),);
  }
}
