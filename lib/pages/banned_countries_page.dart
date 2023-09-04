import 'package:credit_card_validator_app/hive/boxes.dart';
import 'package:credit_card_validator_app/hive/hive.dart' as hive_models;
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BannedCountriesPage extends StatefulWidget {
  const BannedCountriesPage({super.key});

  @override
  State<BannedCountriesPage> createState() => _BannedCountriesPageState();
}

class _BannedCountriesPageState extends State<BannedCountriesPage> {
  // Box<hive_models.Country> boxCountries =
  //     Hive.box<hive_models.Country>('countryBox');
  // @override
  // initState() {
  //   super.initState();
  //   // for (hive_models.Country country in boxCountries.values) {
  //   //   savedBannedCountryCodes.add(country.code);
  //   // }
  // }

  List<String> savedBannedCountryCodes = <String>[];

  void addCountry(Country country) {
    // hive_models.Country newCountry = hive_models.Country(
    //     code: country.countryCode,
    //     name: country.name,
    //     flagEmoji: country.flagEmoji);
    setState(() {
      // boxCountries.put(country.countryCode, newCountry);
      savedBannedCountryCodes.add(country.countryCode);
    });
  }

  void deleteCountry(int index) {
    setState(() {
      // boxCountries.deleteAt(index);
      savedBannedCountryCodes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCountryPicker(
            context: context,
            exclude: savedBannedCountryCodes, //get from hive
            showPhoneCode: false,
            onSelect: (Country country) {
              addCountry(country);
            },
            countryListTheme: CountryListThemeData(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(7.0),
                topRight: Radius.circular(7.0),
              ),
              inputDecoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Select Country',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF8C98A8).withOpacity(0.2),
                  ),
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        // itemCount: boxCountries.length,
        itemCount: [1, 11 ,1].length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: const Color.fromARGB(255, 17, 94, 171),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
              color: Colors.blue[300],
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  'weffew',
                  // boxCountries.getAt(index).flagEmoji,
                ),
                Text(
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    'Hello'),
                // boxCountries.getAt(index).name),
                IconButton(
                  onPressed: () {
                    //deleteCountry(index);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
