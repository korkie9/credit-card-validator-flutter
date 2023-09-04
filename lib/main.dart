// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:credit_card_validator_app/components/components.dart';
import 'package:credit_card_validator_app/hive/country.dart';
import 'package:credit_card_validator_app/hive/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:credit_card_validator_app/hive/boxes.dart';
<<<<<<< HEAD
import 'package:credit_card_validator_app/hive/hive.dart' as hive_models;
=======
import 'package:credit_card_validator_app/hive/hive.dart' as hive;
>>>>>>> 6f7d5dcf4916f9f53d9451552ea0249e5751a39f

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CreditCardAdapter());
<<<<<<< HEAD
  Hive.registerAdapter(CountryAdapter());
  // boxCountries = await Hive.openBox<hive_models.Country>('countryBox');
=======
  Hive.registerAdapter(hive.CountryAdapter());
  boxCountries = await Hive.openBox<hive.Country>('countryBox');
>>>>>>> 6f7d5dcf4916f9f53d9451552ea0249e5751a39f
  boxCreditCards = await Hive.openBox<CreditCard>('creditCardBox');
  runApp(const CreditCardValidatorApp());
}

class CreditCardValidatorApp extends StatelessWidget {
  const CreditCardValidatorApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(119, 153, 168, 90)),
        useMaterial3: true,
      ),
      supportedLocales: const [Locale('en')],
      localizationsDelegates: const [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
<<<<<<< HEAD
  // late Country country;
  // @override
  // initState() {
  //   super.initState();
  //   // country = Country(
  //   //     phoneCode: '27',
  //   //     countryCode: 'ZA',
  //   //     e164Sc: 0,
  //   //     geographic: true,
  //   //     level: 1,
  //   //     name: 'South Africa',
  //   //     example: '711234567',
  //   //     displayName: 'South Africa (ZA) [+27]',
  //   //     displayNameNoCountryCode: 'South Africa (ZA)',
  //   //     e164Key: '27-ZA-0');
  // }
=======
>>>>>>> 6f7d5dcf4916f9f53d9451552ea0249e5751a39f

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cards'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(children: [
                Text(style: TextStyle(fontSize: 20), 'Options'),
                Icon(Icons.menu_open_rounded)
              ]),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('Banned Countries'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BannedCountriesPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: boxCreditCards.listenable(),
        builder: (context, box, widget) {
          if (boxCreditCards.isEmpty) {
            return const Center(
                child: Text(
              'You currently have no cards',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: boxCreditCards.length,
            itemBuilder: (BuildContext context, int index) {
              CreditCard cCard = boxCreditCards.getAt(index);
              return Stack(
                children: <Widget>[
                  CreditCardWidget(
                    creditCardData: cCard,
                  ),
                  Container(
                      alignment: Alignment.topRight,
                      child: FloatingActionButton.small(
                        splashColor: Colors.amber,
                        backgroundColor: Colors.red[400],
                        onPressed: () {
                          setState(() {
                            boxCreditCards.deleteAt(index);
                          });
                        },
                        child: const Icon(Icons.delete),
                      ))
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCardPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
