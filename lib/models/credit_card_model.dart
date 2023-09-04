import 'package:country_picker/country_picker.dart';

class CreditCardModel {
  final String? cardType;
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvv;
  final Country country;

  CreditCardModel({
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvv,
    required this.country,
    this.cardType,
  });
}
