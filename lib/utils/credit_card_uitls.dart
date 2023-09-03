import 'package:flutter/material.dart';

//I copied the code in this file from a github repo and modified and refactored it to fit
//this project's usecase
//The original code can be found at:
//https://github.com/wilburx9/Payment-Card-Validation/blob/master/lib/payment_card.dart

enum CardType {
  mastercard,
  visa,
  verve,
  discover,
  americanExpress,
  dinersClub,
  jcb,
  other,
  invalid
}


class CardUtils {

  // Todo: added missing card type checks

  static CardType getCreditCardType(String input) {
    if (input.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      return CardType.mastercard;
    }
    if (input.startsWith(RegExp(r'[4]'))) return CardType.visa;
    if (input.startsWith(RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
      return CardType.verve;
    }
    if (input.startsWith(RegExp(r'((34)|(37))'))) {
      return CardType.americanExpress;
    }
    if (input.startsWith(RegExp(r'((6[45])|(6011))'))) return CardType.discover;
    if (input.startsWith(RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
      return CardType.dinersClub;
    }
    if (input.startsWith(RegExp(r'(352[89]|35[3-8][0-9])'))) {
      return CardType.jcb;
    }
    if (input.length <= 8) return CardType.other;
    return CardType.invalid;
  }

  static Widget getCreditCardIcon(String type) {
    CardType cardType = getCreditCardType(type);
    if (cardType == CardType.invalid || cardType == CardType.other) {
      return const Icon(Icons.credit_card);
    }
    String typeString = cardType.name;
    return Image.asset('assets/images/$typeString.png');
  }
}
