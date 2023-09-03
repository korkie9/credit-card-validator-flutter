// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:country_picker/country_picker.dart';
import 'pages/pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
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

class CreditCardModel {
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  bool showBackView;

  CreditCardModel({
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    required this.showBackView,
  });
}

class _HomePageState extends State<HomePage> {
  final List<CreditCardModel> creditCards = [
    CreditCardModel(
        cardNumber: '103737367280',
        expiryDate: '12/11/2021',
        cardHolderName: 'Justin Korkie',
        cvvCode: '901',
        showBackView: false),
    CreditCardModel(
        cardNumber: '2098797987987980',
        expiryDate: '12/11/2021',
        cardHolderName: 'Kevin Spacey',
        cvvCode: '901',
        showBackView: false),
    CreditCardModel(
        cardNumber: '398798798798700',
        expiryDate: '12/11/2021',
        cardHolderName: 'John Doe',
        cvvCode: '901',
        showBackView: false),
    CreditCardModel(
        cardNumber: '309879879879870',
        expiryDate: '12/11/2021',
        cardHolderName: 'John Doe',
        cvvCode: '901',
        showBackView: false),
  ];

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
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: creditCards.length,
        itemBuilder: (BuildContext context, int index) {
          return CreditCardWidget(
            cardBgColor: const Color.fromARGB(18, 16, 16, 16),
            obscureCardCvv: false,
            obscureCardNumber: false,
            obscureInitialCardNumber: false,
            animationDuration: const Duration(
                days: 0,
                hours: 0,
                minutes: 0,
                seconds: 1,
                milliseconds: 0,
                microseconds: 0),
            isChipVisible: true,
            //Todo: edit this to allow custom images
            customCardTypeIcons: [CustomCardTypeIcon(cardType: CardType.otherBrand, cardImage: Image.asset('assets/images/verve.png'))],
            isHolderNameVisible: true,
            //Todo: Model will need two card type fields, to account for tyep not found on card type
            cardType: CardType.hipercard,
            cardNumber: creditCards[index].cardNumber,
            expiryDate: creditCards[index].expiryDate,
            cardHolderName: creditCards[index].cardHolderName,
            cvvCode: creditCards[index].cvvCode,
            showBackView: creditCards[index].showBackView,
            onCreditCardWidgetChange:
                (creditCardBrand) {}, //true when you want to show cvv(back) view
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
