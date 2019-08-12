import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teleport/blocs/MainBloc.dart';
import 'package:teleport/common_utils/CodeConstants.dart';
 import 'package:teleport/common_utils/SharedPref.dart';
import 'package:teleport/ui/pages/functionality/Home.dart';
import 'package:teleport/ui/pages/functionality/Settings.dart';
import 'package:teleport/ui/pages/functionality/UserProfile.dart';

import 'Login.dart';

class Splash extends StatefulWidget {
  Splash();

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    var screen;

    SharedPref().get(CodeConstants.USER_ID).then((uid) {
      if (uid == null)
        screen = Login();
      else {
        screen = Home();
      }
    });

    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (BuildContext context) => screen),
            (_) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Image(
            image: AssetImage("assets/images/logo.png"),
          ),
        ],
      ),
    );
  }
}
