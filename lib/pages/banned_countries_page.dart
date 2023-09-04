import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class BannedCountriesPage extends StatefulWidget {
  const BannedCountriesPage({super.key});

  @override
  State<BannedCountriesPage> createState() => _BannedCountriesPageState();
}

class _BannedCountriesPageState extends State<BannedCountriesPage> {
  @override
  initState() {
    super.initState();
    for (Country country in saveBannedCountries) {
      savedBannedCountryCodes.add(country.countryCode);
    }
  }

  //Todo: Get from hive
  List<String> savedBannedCountryCodes = <String>[];
  List<Country> saveBannedCountries = <Country>[
    Country(
        phoneCode: '27',
        countryCode: 'US',
        e164Sc: 0,
        geographic: true,
        level: 1,
        name: 'United States of America',
        example: '711234567',
        displayName: 'South Africa (ZA) [+27]',
        displayNameNoCountryCode: 'South Africa (ZA)',
        e164Key: '27-ZA-0'),
    Country(
        phoneCode: '27',
        countryCode: 'NGA',
        e164Sc: 0,
        geographic: true,
        level: 1,
        name: 'Nigeria',
        example: '711234567',
        displayName: 'South Africa (ZA) [+27]',
        displayNameNoCountryCode: 'South Africa (ZA)',
        e164Key: '27-ZA-0'),
    Country(
        phoneCode: '27',
        countryCode: 'CA',
        e164Sc: 0,
        geographic: true,
        level: 1,
        name: 'Canada',
        example: '711234567',
        displayName: 'South Africa (ZA) [+27]',
        displayNameNoCountryCode: 'South Africa (ZA)',
        e164Key: '27-ZA-0'),
  ];

  //Todo: adjust the following 2 functions to work with hive
  void addCountry(Country country) {
    setState(() {
      saveBannedCountries.add(country);
      savedBannedCountryCodes.add(country.countryCode);
    });
  }

  void deleteCountry(int index) {
    setState(() {
      saveBannedCountries.removeAt(index);
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
        itemCount: saveBannedCountries.length,
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
                    saveBannedCountries[index].flagEmoji),
                Text(
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    saveBannedCountries[index].name),
                IconButton(
                  onPressed: () {
                    //delete from hive
                    deleteCountry(index);
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
