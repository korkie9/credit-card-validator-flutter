import 'package:credit_card_validator/input_formatters/input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _addCardFormKey = GlobalKey<FormState>();
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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _addCardFormKey,
          child: Column(
            children: [
              buildCardNumber(),
              buildCVV(),
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
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            labelText: 'Card Number',
            border: OutlineInputBorder(),
            icon: Icon(Icons.credit_card)),
        maxLength: 19,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(19),
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter Number on Card';
          }
          return null;
        },
      ));

  Widget buildCVV() => Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            labelText: 'CVV',
            border: OutlineInputBorder(),
            icon: Icon(Icons.numbers)),
        maxLength: 3,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a valid CVV';
          }
          return null;
        },
      ));

  Widget buildIssuingCountry() => Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            labelText: 'Country',
            border: OutlineInputBorder(),
            icon: Icon(Icons.flag)),
        maxLength: 50,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a valid country';
          }
          return null;
        },
      ));

  Widget buildSubmitButton() => ElevatedButton(
        onPressed: () {
          final isValid = _addCardFormKey.currentState?.validate();
        },
        child: const Text(
          'CVV',
          style: TextStyle(fontSize: 15),
        ),
      );
}
