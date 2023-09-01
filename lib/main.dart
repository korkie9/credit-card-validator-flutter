// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'pages/pages.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
        cardNumber: '100',
        expiryDate: '12/11/2021',
        cardHolderName: 'Justin Korkie',
        cvvCode: '901',
        showBackView: false),
    CreditCardModel(
        cardNumber: '200',
        expiryDate: '12/11/2021',
        cardHolderName: 'Kevin Spacey',
        cvvCode: '901',
        showBackView: false),
    CreditCardModel(
        cardNumber: '300',
        expiryDate: '12/11/2021',
        cardHolderName: 'John Doe',
        cvvCode: '901',
        showBackView: false),
    CreditCardModel(
        cardNumber: '300',
        expiryDate: '12/11/2021',
        cardHolderName: 'John Doe',
        cvvCode: '901',
        showBackView: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                    style: TextStyle(fontSize: 20), 'Credit Card Validator'),
              ),
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
            cardNumber: creditCards[index].cardNumber,
            expiryDate: creditCards[index].expiryDate,
            cardHolderName: creditCards[index].cardHolderName,
            cvvCode: creditCards[index].cvvCode,
            showBackView: creditCards[index].showBackView,
            onCreditCardWidgetChange:
                (CreditCardBrand) {}, //true when you want to show cvv(back) view
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      // body: CreditCardWidget(
      //   cardNumber: '0000',
      //   expiryDate: '12/11/12',
      //   cardHolderName: 'Justin Korkie',
      //   cvvCode: '901',
      //   showBackView: true,
      //   onCreditCardWidgetChange:
      //       (CreditCardBrand) {}, //true when you want to show cvv(back) view
      // ),
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
