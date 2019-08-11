import 'package:flutter/cupertino.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:teleport/blocs/AddCardBloc.dart';

class AddCard {


  BuildContext context;

  AddCard(this.context);

  AddCardBloc _bloc=AddCardBloc();

  Future<String> getCard() {

    StripeSource.setPublishableKey("pk_test_bmXdPV8uYmDwrMLJP9j0JrKg");
    return StripeSource.addSource().then((String token) {
      _bloc.saveCard(token, context);
      return token;
    }).catchError((error) {
      return error.toString();
    });
  }
}
