import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'localize_event.dart';
part 'localize_state.dart';

class LocalizeBloc extends Bloc<LocalizeEvent, LocalizeState> {
  LocalizeBloc() : super(LocalizeInitial()) {
    on<LocalizeEvent>((event, emit) {
      if(event is ChangeLocale){
        emit(ChangeLocaleInProgress());
        emit(ChangeLocaleSuccess(locale: event.locale));
      }
    });
  }

  void changeLocale({required String locale}){
    add(ChangeLocale(locale: locale));
  }
}
