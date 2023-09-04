import 'package:hive/hive.dart';
part 'country.g.dart';

<<<<<<< HEAD
@HiveType(typeId: 2)
=======
@HiveType(typeId: 1)
>>>>>>> 6f7d5dcf4916f9f53d9451552ea0249e5751a39f
class Country {
  Country({
    required this.code,
    required this.name,
    required this.flagEmoji,
  });

  @HiveField(0)
  String code;

  @HiveField(1)
  String name;

  @HiveField(2)
  String flagEmoji;
<<<<<<< HEAD
}
=======
}
>>>>>>> 6f7d5dcf4916f9f53d9451552ea0249e5751a39f
