class Pokemon {
  Pokemon({
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.xDescription,
    required this.yDescription,
    required this.height,
    required this.category,
    required this.weight,
    required this.typeOfPokemon,
    required this.weaknesses,
    required this.evolutions,
    required this.abilities,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
    required this.total,
    required this.malePercentage,
    required this.femalePercentage,
    required this.genderless,
    required this.cycles,
    required this.eggGroups,
    required this.evolvedFrom,
    required this.reason,
    required this.baseExp,
  });

  final String name;
  final String id;
  final String imageUrl;
  final String xDescription;
  final String yDescription;
  final String height;
  final String category;
  final String weight;
  final List<String> typeOfPokemon;
  final List<String> weaknesses;
  final List<String> evolutions;
  final List<String> abilities;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;
  final int total;
  final String malePercentage;
  final String femalePercentage;
  final int genderless;
  final String cycles;
  final String eggGroups;
  final String evolvedFrom;
  final String reason;
  final String baseExp;

  Pokemon copyWith({
    required String name,
    required String id,
    required String imageUrl,
    required String xDescription,
    required String yDescription,
    required String height,
    required String category,
    required String weight,
    required List<String> typeOfPokemon,
    required List<String> weaknesses,
    required List<String> evolutions,
    required List<String> abilities,
    required int hp,
    required int attack,
    required int defense,
    required int specialAttack,
    required int specialDefense,
    required int speed,
    required int total,
    required String malePercentage,
    required String femalePercentage,
    required  genderless,
    required String cycles,
    required String eggGroups,
    required String evolvedFrom,
    required String reason,
    required String baseExp,
  }) =>
      Pokemon(
        name: name,
        id: id,
        imageUrl: imageUrl,
        xDescription: xDescription,
        yDescription: yDescription,
        height: height,
        category: category,
        weight: weight,
        typeOfPokemon: typeOfPokemon,
        weaknesses: weaknesses,
        evolutions: evolutions,
        abilities: abilities,
        hp: hp,
        attack: attack,
        defense: defense,
        specialAttack: specialAttack,
        specialDefense: specialDefense,
        speed: speed,
        total: total,
        malePercentage: malePercentage,
        femalePercentage: femalePercentage,
        genderless: genderless ?? this.genderless,
        cycles: cycles,
        eggGroups: eggGroups,
        evolvedFrom: evolvedFrom,
        reason: reason,
        baseExp: baseExp,
      );
}
