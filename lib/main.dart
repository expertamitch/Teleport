import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:teleport/common_utils/Palette.dart';
import 'package:teleport/ui/pages/auth/Splash.dart';

import 'blocs/MainBloc.dart';
import 'common_utils/Palette.dart';

void main() => runApp(EasyLocalization(
  child: TeleportApp(),
));

//here
//joban
class TeleportApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          //app-specific localization
          EasylocaLizationDelegate(
              locale: data.locale ?? Locale('en', 'US'), path: 'assets/langs'),
        ],
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', 'DZ'),
          Locale('hi', 'IN')
        ],
        locale: data.locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
//        primarySwatch: Colors.red,
//          primaryColor: Colors.lightBlue[800],
          primaryColor: Palette.primary,
          accentColor: Colors.white,

          // Define the default Font Family
          fontFamily: 'SourceSansPro',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.

          textTheme: TextTheme(
              headline: TextStyle(
                  fontSize: 42.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
              subhead: TextStyle(fontSize: 25.0, color: Palette.primary),
              title: TextStyle(fontSize: 36.0, color: Colors.white),
              subtitle: TextStyle(fontSize: 20.0, color: Colors.white),
              body1: TextStyle(
                fontSize: 14.0,
                color: Palette.ocean_blue,
                fontWeight: FontWeight.bold,
                fontFamily: 'SourceSansPro',
              ),
              body2: TextStyle(
                fontSize: 14.0,
                color: Palette.darkPrimary,
                fontFamily: 'SourceSansPro',
              ),
              button: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontFamily: 'SourceSansPro',
              )),
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage();

  MainBloc bloc = MainBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Splash());
  }
}
