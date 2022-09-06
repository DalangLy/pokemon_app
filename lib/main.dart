import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/cores/blocs/localize/localize_bloc.dart';
import 'package:pokemon_app/cores/blocs/theme/theme_bloc.dart';
import 'package:pokemon_app/features/home/data/data_sources/pokemon_remote_data_source_using_dio.dart';
import 'package:pokemon_app/features/home/data/repositories/PokemonRepository.dart';
import 'package:pokemon_app/features/home/domain/use_cases/get_all_pokemon_use_case.dart';
import 'package:pokemon_app/features/home/presentation/blocs/add_to_favorite/add_to_favorite_bloc.dart';
import 'package:pokemon_app/features/home/presentation/blocs/get_all_pokemon_bloc.dart';
import 'package:pokemon_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = Locale('en');
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc(),),
        BlocProvider(create: (context) => LocalizeBloc(),),
        BlocProvider(create: (context) =>
            GetAllPokemonBloc(GetAllPokemonUseCase(
              PokemonRepository(PokemonRemoteDataSourceUsingDio(Dio(),),),),),),
        BlocProvider(create: (context) => AddToFavoriteBloc(context.read<GetAllPokemonBloc>()),)
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ThemeBloc, ThemeState>(listener: (context, state) {
            if(state is ChangeThemeSuccess){
              setState(() {
                _themeMode = state.themeMode;
              });
            }
          },),
          BlocListener<LocalizeBloc, LocalizeState>(listener: (context, state) {
            if(state is ChangeLocaleSuccess){
              setState(() {
                _locale = Locale(state.locale);
              });
            }
          },),
        ],
        child: MaterialApp(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.title,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: _locale,
          themeMode: _themeMode,
          home: const HomePage(),
        ),
      ),
    );
  }
}