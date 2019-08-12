import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teleport/blocs/SettingsBloc.dart';
import 'package:teleport/blocs/CommonSingleton.dart';
import 'package:teleport/common_utils/SharedPref.dart';
import 'package:teleport/ui/pages/auth/Login.dart';
import 'package:teleport/ui/widgets/CustomRadio.dart';
//import 'package:stripe_payment/stripe_payment.dart';

import '../../../common_utils/Palette.dart';
import 'RideSettings.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsBloc _bloc = SettingsBloc();
  List<RadioModel> sampleData = new List<RadioModel>();
  int s = 1;

  @override
  void initState() {
//    StripeSource.setPublishableKey("pk_live_Q3zDoPTAI1fbzWLX2J3c5I8X");
//    StripeSource.addSource().then((String token) {
//      print(token); //your stripe card source token
//    });

    // TODO: implement initState
    super.initState();
    s = commonSingleton.rider.value ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    var al = AppLocalizations.of(context);
    var size = MediaQuery.of(context).size;
    var data = EasyLocalizationProvider.of(context).data;

    if (sampleData.length == 0) {
      sampleData.add(new RadioModel(!commonSingleton.rider.value,
          "assets/images/driver.png", al.tr("settings.driver")));
      sampleData.add(new RadioModel(commonSingleton.rider.value,
          "assets/images/rider.png", al.tr("settings.rider")));
    }

    Widget mode = Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            getSizedBox(size.width * 0.05, 0.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  al.tr("settings.mode_settings"),
                  style: Theme.of(context).textTheme.body1,
                ),
                Container(
                  height: 70,
                  child: ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        splashColor: Palette.primary700,
                        onTap: () {
                          setState(() {
                            sampleData.forEach(
                                (element) => element.isSelected = false);
                            sampleData[index].isSelected = true;

                            if (sampleData[1].isSelected) {
//                              rider selected
//                              only update if this is changed
                              if (s == 0) {
                                _bloc.updateProfile(true, context);
                                s = 1;
                              }
                            } else {
//                              driver selected
                              // only update if this is changed
                              if (s == 1) {
                                _bloc.updateProfile(false, context);
                                s = 0;
                              }
                            }
                          });
                        },
                        child: new CustomRadio(sampleData[index]),
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
        getSizedBox(0.0, 3.0),
        Divider(
          height: 1,
          color: Palette.darkPrimary,
        ),
      ],
    );

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
                    al.tr("settings.ride_settings"),
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    al.tr("settings.ride_settings_info"),
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
        navigateToRideSettings();
      },
      splashColor: Palette.primary700,
    );

    Widget logout = StreamBuilder(
      stream: _bloc.isloading,
      builder: (context, AsyncSnapshot snapshot) {
        return InkWell(
          child: Column(
            children: <Widget>[
              getSizedBox(0.0, 3.0),
              Row(
                children: <Widget>[
                  getSizedBox(size.width * 0.05, 0.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      snapshot.data
                          ? Container(
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                              height: 20,
                              width: 20,
                            )
                          : Text(
                              al.tr("settings.logout"),
                              style: Theme.of(context)
                                  .textTheme
                                  .body1
                                  .copyWith(fontSize: 18),
                            ),
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
            _bloc.logout(context);
          },
        );
      },
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
          Card(
            child: Container(
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  //                          begin: Alignment.topRight,
//                          end: Alignment.bottomLeft,
                  colors: [
                    // Colors are easy thanks to Flutter's Colors class.
                    Palette.primary10,
                    Palette.primary20,
                  ],
                ),
              ),
              child: Column(
                children: <Widget>[
                  getSizedBox(0.0, 10.0),
                  Row(
                    children: <Widget>[
                      getSizedBox(size.width * 0.02, 0.0),
                      commonSingleton.image.value.isEmpty
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.width * 0.2,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage("assets/images/user.png"),
                                  )))
                          : Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.width * 0.2,
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(commonSingleton.image.value),
                              ),
                            ),
                      getSizedBox(size.width * 0.03, 0.0),
                      Container(
                          width: size.width * 0.6,
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
                              Text(commonSingleton.email.value,
                                  style: Theme.of(context).textTheme.body2),
                              Text(commonSingleton.phoneNumber.value,
                                  style: Theme.of(context).textTheme.body2)
                            ],
                          ))
                    ],
                  ),
                  getSizedBox(0.0, 10.0)
                ],
              ),
            ),
          ),
          getSizedBox(0.0, 10.0),
          mode,
          rideSettings,
          logout
//          getLogout(size, context, al)
        ],
      ),
    );

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(child: Icon(Icons.arrow_back_ios), onTap:(){
            Navigator.of(context).pop();
          },),
          title: Text(
            al.tr("settings.title"),
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(color: Colors.white),
          ),
        ),
        body: Stack(
          children: <Widget>[body],
        ),
      ),
    );
  }

  Widget getSizedBox(width, height) {
    return SizedBox(
      width: width,
      height: height,
    );
  }

  void navigateToRideSettings() {
    Navigator.of(context).push(
        CupertinoPageRoute(builder: (BuildContext context) => RideSettings()));
  }
}
