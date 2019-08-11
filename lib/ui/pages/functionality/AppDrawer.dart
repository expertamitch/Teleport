import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:teleport/blocs/CommonSingleton.dart';
import 'package:teleport/ui/pages/stripe/AddCard.dart';
import '../../../common_utils/Palette.dart';
import 'Settings.dart';
import 'UserProfile.dart';
import 'RideHistory.dart';
import 'package:stripe_payment/stripe_payment.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var al = AppLocalizations.of(context);
    var data = EasyLocalizationProvider.of(context).data;

    Widget rideSettings = InkWell(
      child: Column(
        children: <Widget>[
          getSizedBox(0.0, 8.0),
          Row(
            children: <Widget>[
              getSizedBox(size.width * 0.05, 0.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    al.tr("drawer.settings"),
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    al.tr("drawer.settings_info"),
                    style: Theme.of(context).textTheme.body2,
                  )
                ],
              )
            ],
          ),
          getSizedBox(0.0, 8.0),
          Divider(
            height: 1,
            color: Palette.darkPrimary,
          ),
        ],
      ),
      onTap: () {
        navigateToSettings();
      },
      splashColor: Palette.primary700,
    );

    Widget addPaymentOptions = InkWell(
      child: Column(
        children: <Widget>[
          getSizedBox(0.0, 8.0),
          Row(
            children: <Widget>[
              getSizedBox(size.width * 0.05, 0.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    al.tr("drawer.payment_options"),
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    al.tr("drawer.payment_options_info"),
                    style: Theme.of(context).textTheme.body2,
                  )
                ],
              )
            ],
          ),
          getSizedBox(0.0, 8.0),
          Divider(
            height: 1,
            color: Palette.darkPrimary,
          ),
        ],
      ),
      onTap: () {
        paymentOptions();
      },
      splashColor: Palette.primary700,
    );

    Widget rideHistory = InkWell(
      child: Column(
        children: <Widget>[
          getSizedBox(0.0, 8.0),
          Row(
            children: <Widget>[
              getSizedBox(size.width * 0.05, 0.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    al.tr("drawer.ride_history"),
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    al.tr("drawer.ride_history_info"),
                    style: Theme.of(context).textTheme.body2,
                  )
                ],
              )
            ],
          ),
          getSizedBox(0.0, 8.0),
          Divider(
            height: 1,
            color: Palette.darkPrimary,
          ),
        ],
      ),
      onTap: () {
        navigateToRideHistory();
      },
      splashColor: Palette.primary700,
    );

    Widget profile = InkWell(
      child: Column(
        children: <Widget>[
          getSizedBox(0.0, 8.0),
          Row(
            children: <Widget>[
              getSizedBox(size.width * 0.05, 0.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    al.tr("drawer.profile"),
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    al.tr("drawer.profile_info"),
                    style: Theme.of(context).textTheme.body2,
                  )
                ],
              )
            ],
          ),
          getSizedBox(0.0, 8.0),
          Divider(
            height: 1,
            color: Palette.darkPrimary,
          ),
        ],
      ),
      onTap: () {
        navigateToEditProfile();
      },
      splashColor: Palette.primary700,
    );

    Widget aboutus = InkWell(
      child: Column(
        children: <Widget>[
          getSizedBox(0.0, 8.0),
          Row(
            children: <Widget>[
              getSizedBox(size.width * 0.05, 0.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    al.tr("drawer.about_us"),
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    al.tr("drawer.about_us_info"),
                    style: Theme.of(context).textTheme.body2,
                  )
                ],
              )
            ],
          ),
          getSizedBox(0.0, 8.0),
          Divider(
            height: 1,
            color: Palette.darkPrimary,
          ),
        ],
      ),
      onTap: () {
//        navigateToSettings();
      },
      splashColor: Palette.primary700,
    );

    Widget body = Container(
      decoration: new BoxDecoration(
          gradient: LinearGradient(
        //                          begin: Alignment.topRight,
//                          end: Alignment.bottomLeft,
        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          Palette.primary1,
          Palette.primary3,
        ],
      )),
      child: Column(
        children: <Widget>[
          DrawerHeader(
              child: Container(
            child: Column(
              children: <Widget>[
                getSizedBox(0.0, 10.0),
                Row(
                  children: <Widget>[
                    getSizedBox(size.width * 0.03, 0.0),
                    commonSingleton.image.value != null
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.width * 0.2,
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(commonSingleton.image.value),
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.width * 0.2,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/images/user.png"),
                                ))),
                    getSizedBox(size.width * 0.03, 0.0),
                    Container(
                        width: size.width * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              commonSingleton.nickName.value != null
                                  ? commonSingleton.nickName.value
                                  : commonSingleton.firstName.value +
                                      " " +
                                      commonSingleton.lastName.value,
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ],
                        ))
                  ],
                ),
                getSizedBox(0.0, 10.0)
              ],
            ),
          )),
          getSizedBox(0.0, 10.0),
          rideSettings,
          addPaymentOptions,
          profile,
          rideHistory,
          aboutus
        ],
      ),
    );

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        body: body,
      ),
    );
  }

  Widget getSizedBox(width, height) {
    return SizedBox(
      width: width,
      height: height,
    );
  }

  void navigateToSettings() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => Settings()));
  }

  void navigateToEditProfile() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => UserProfile()));
  }

  void navigateToRideHistory() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => RideHistory()));
  }

  void paymentOptions() {
    AddCard(context).getCard();


//    StripeSource.setPublishableKey("pk_test_bmXdPV8uYmDwrMLJP9j0JrKg");
//    StripeSource.addSource().then((String token) {
//      print(token); //your stripe card source token
//    });
  }
}
