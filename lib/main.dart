// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:credit_card_validator_app/components/components.dart';
import 'package:credit_card_validator_app/hive/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/models.dart';
import 'pages/pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:credit_card_validator_app/hive/boxes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CreditCardAdapter());
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
  late Country country;
  @override
  initState() {
    super.initState();
    country = Country(
        phoneCode: '27',
        countryCode: 'ZA',
        e164Sc: 0,
        geographic: true,
        level: 1,
        name: 'South Africa',
        example: '711234567',
        displayName: 'South Africa (ZA) [+27]',
        displayNameNoCountryCode: 'South Africa (ZA)',
        e164Key: '27-ZA-0');
  }

  @override
  Widget build(BuildContext context) {
    //Todo: Get from hive
    // final List<CreditCardModel> creditCards = [
    //   CreditCardModel(
    //       cardNumber: '103737367280',
    //       expiryDate: '12/11/2021',
    //       cardHolderName: 'Justin Korkie',
    //       cvv: '901',
    //       country: country,
    //       cardType: 'mastercard'),
    //   CreditCardModel(
    //     cardNumber: '2098797987987980',
    //     expiryDate: '12/11/2021',
    //     cardHolderName: 'Kevin Spacey',
    //     cvv: '901',
    //     country: country,
    //   ),
    //   CreditCardModel(
    //     cardNumber: '398798798798700',
    //     expiryDate: '12/11/2021',
    //     cardHolderName: 'John Doe',
    //     cvv: '901',
    //     country: country,
    //   ),
    //   CreditCardModel(
    //     cardNumber: '309879879879870',
    //     expiryDate: '12/11/2021',
    //     cardHolderName: 'John Doe',
    //     cvv: '901',
    //     country: country,
    //   ),
    // ];
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
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: boxCreditCards.length,
        itemBuilder: (BuildContext context, int index) {
          CreditCard cc = boxCreditCards.getAt(index);
          return Stack(
            children: <Widget>[
              CreditCardWidget(
                creditCardData: boxCreditCards.getAt(index),
              ),
              Container(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton.small(
                    splashColor: Colors.amber,
                    backgroundColor: Colors.red[400],
                    onPressed: () {},
                    child: const Icon(Icons.delete),
                  ))
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
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
