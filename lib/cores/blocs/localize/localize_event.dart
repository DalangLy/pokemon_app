part of 'localize_bloc.dart';

abstract class LocalizeEvent extends Equatable {
  const LocalizeEvent();
}

class ChangeLocale extends LocalizeEvent {
  final String locale;
  const ChangeLocale({required this.locale,});

  @override
  List<Object> get props => [];
}