import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/features/home/data/data_sources/pokemon_remote_data_source_using_dio.dart';
import 'package:pokemon_app/features/home/data/repositories/PokemonRepository.dart';
import 'package:pokemon_app/features/home/domain/use_cases/get_all_pokemon_use_case.dart';
import 'package:pokemon_app/features/home/presentation/blocs/get_all_pokemon_bloc.dart';
import 'package:pokemon_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAllPokemonBloc(GetAllPokemonUseCase(PokemonRepository(PokemonRemoteDataSourceUsingDio(Dio(),),),),),
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
        locale: const Locale('km'),
        themeMode: ThemeMode.light,
        home: const HomePage(),
      ),
    );
  }
}