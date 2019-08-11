import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teleport/common_utils/Palette.dart';
import 'package:teleport/ui/pages/stripe/AddCard.dart';

class ContactSupportDialog {
  String message;

  ContactSupportDialog(context, message) {
    _showDialog(context, message);
  }

  void _showDialog(context, message) {
    var al = AppLocalizations.of(context);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: new Text(
              al.tr("error.error"),
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(color: Palette.rouge),
            ),
            content: new Text(message),
            actions: [
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: new Text(al.tr("navigate.contact_support")),
                  onPressed: () {
//                    TODO functionality for support system
//                    AddCard().getCard();
                    Navigator.pop(
                      context,
                    );
                  }),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: new Text(al.tr("navigate.close")),
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  }),
            ],
          );
        });
  }
}
