import 'package:credit_card_validator/validation_results.dart';
import 'package:credit_card_validator_app/hive/boxes.dart';
import 'package:credit_card_validator_app/hive/credit_card.dart';
import 'package:credit_card_validator_app/input_formatters/input_formatters.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';
import 'package:credit_card_validator_app/utils/utils.dart';
import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:developer';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _addCardFormKey = GlobalKey<FormState>();
  String cardTypePath = '';
  //Controllers
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();

  final CreditCardValidator _ccValidator = CreditCardValidator();

  Country selectedCountry = Country(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _addCardFormKey,
          child: Column(
            children: <Widget>[
              buildName(),
              buildCardNumber(),
              Row(
                children: [
                  Expanded(
                    child: buildCVV(),
                  ),
                  Expanded(
                    child: buildDate(),
                  ),
                ],
              ),
              buildIssuingCountry(),
              buildSubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardNumber() => Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: TextFormField(
          controller: cardNumberController,
          onChanged: (value) {
            if (value.length > 4) return;
            setState(() {
              cardTypePath = value;
            });
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Card Number',
            border: const OutlineInputBorder(),
            icon: SizedBox(
              width: 25,
              child: CardUtils.getCreditCardIcon(cardTypePath),
            ),
          ),
          maxLength: 19,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(19),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Number on Card';
            }
            if (!_ccValidator.validateCCNum(value).isValid) {
              return 'Credit Card Number is invalid';
            }
            return null;
          },
        ),
      );

  Widget buildCVV() => Container(
      padding: const EdgeInsets.only(right: 10),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        controller: cvvController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'CVV',
          border: OutlineInputBorder(),
          icon: SizedBox(
            // width: 25,
            child: Icon(Icons.numbers),
          ),
        ),
        maxLength: 3,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          if (value == null || value.length < 3 || value.length > 4) {
            return 'Invalid CVV';
          }
          return null;
        },
      ));

  Widget buildIssuingCountry() => Container(
        margin: const EdgeInsets.only(top: 10, bottom: 25),
        child: Row(
          children: <Widget>[
            const Icon(Icons.flag),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: SizedBox(
                width: 310,
                height: 50,
                child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                  ),
                  onPressed: () {
                    showCountryPicker(
                      context: context,
                      exclude: <String>['KN', 'MF'],
                      showPhoneCode: false,
                      onSelect: (Country country) {
                        setState(() {
                          selectedCountry = country;
                        });
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedCountry.flagEmoji),
                        Text(selectedCountry.name),
                        const Icon(Icons.arrow_drop_down)
                      ]),
                ),
              ),
            )
          ],
        ),
      );

  Widget buildSubmitButton() {
    return SizedBox(
      width: 400,
      child: ElevatedButton(
        onPressed: () {
          bool? isValid = _addCardFormKey.currentState?.validate();
          if (isValid != null && isValid) {
            CreditCard newCard = CreditCard(
              cardNumber: cardNumberController.text,
              expiryDate: expiryDateController.text,
              cardHolderName: cardHolderNameController.text,
              cvv: cvvController.text,
              countryFlagEmoji: selectedCountry.flagEmoji,
            );
            setState(() {
              boxCreditCards
                  .add(newCard)
                  .then((value) => Navigator.pop(context));
            });
          }
        },
        child: const Text(
          'Submit',
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  Widget buildName() => Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        controller: cardHolderNameController,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          labelText: 'Name of Card Holder',
          border: OutlineInputBorder(),
          icon: SizedBox(
            width: 25,
            child: Icon(Icons.person),
          ),
        ),
        maxLength: 50,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z\s]'))
        ],
        validator: (value) {
          if (value == null || value.length < 2) {
            return 'Name must contain at least 2 digits';
          }
          return null;
        },
      ));

  Widget buildDate() => Container(
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        controller: expiryDateController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Expiry Date',
          border: OutlineInputBorder(),
          icon: SizedBox(
            // width: 25,
            child: Icon(Icons.date_range),
          ),
        ),
        maxLength: 5,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          CardMonthInputFormatter()
        ],
        validator: (value) {
          ValidationResults datavalidator =
              _ccValidator.validateExpDate(value!);
          if (value.length < 2) {
            return 'Invalid Date';
          }
          if (!datavalidator.isValid) {
            return 'Date is invalid';
          }
          return null;
        },
      ));
}
