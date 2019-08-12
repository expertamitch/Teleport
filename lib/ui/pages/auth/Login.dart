import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teleport/blocs/LoginBloc.dart';
import 'package:teleport/common_utils/Palette.dart';

import 'SignUp.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignInScreenState();
}

class SignInScreenState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  bool _isPasswordObscured = true;
  LoginBloc _bloc;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  Widget emailField(al) {
    return StreamBuilder(
      stream: _bloc.email,
      builder: (context, AsyncSnapshot<String> snapshot) {
        _emailController.value =
            _emailController.value.copyWith(text: snapshot.data);
        return TextFormField(
            controller: _emailController,
            onSaved: _bloc.changeEmail,
            focusNode: _emailFocusNode,
            textInputAction: TextInputAction.next,
            validator: _bloc.emailValidator,
            onFieldSubmitted: (val) {
//              _formKey.currentState.save()
              _emailFocusNode.unfocus();
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.start,
            style: new TextStyle(
                fontFamily: "SourceSansPro",
                color: Colors.black,
                height: 0.2,
                fontSize: 14),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black, fontSize: 14),
              fillColor: Colors.white,
              errorText: snapshot.error,
              labelText: al.tr("login.email"),
              focusedBorder: const OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide:
                    const BorderSide(color: Palette.primary800, width: 1.3),
              ),
              enabledBorder: const OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide:
                    const BorderSide(color: Palette.primary400, width: 1.0),
              ),
              border: const OutlineInputBorder(),
            ));
      },
    );
  }

  Widget passwordField(al) {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 8),
      child: StreamBuilder(
        stream: _bloc.password,
        builder: (context, AsyncSnapshot<String> snapshot) {
          _passwordController.value =
              _passwordController.value.copyWith(text: snapshot.data);
          return TextFormField(
            validator: _bloc.passwordValidator,
            textInputAction: TextInputAction.done,
            controller: _passwordController,
            onFieldSubmitted: (val) {
//              _formKey.currentState.save();
              _passwordFocusNode.unfocus();
            },

            onSaved: _bloc.changePassword,
            focusNode: _passwordFocusNode,
            textAlign: TextAlign.start,
            style: new TextStyle(
                fontFamily: "SourceSansPro",
                color: Colors.black,
                height: 0.2,
                fontSize: 14),

            decoration: InputDecoration(
              fillColor: Colors.white,
              labelStyle: TextStyle(color: Colors.black, fontSize: 14),
              labelText: al.tr('login.password'),
              errorText: snapshot.error,
              suffixIcon: IconButton(
                color: Palette.primary,
                disabledColor: Palette.primary400,
                icon: Icon(Icons.visibility_off),
                onPressed: _toggle,
              ),
              focusedBorder: const OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide:
                    const BorderSide(color: Palette.primary800, width: 1.3),
              ),
              enabledBorder: const OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide:
                    const BorderSide(color: Palette.primary400, width: 1.0),
              ),
              border: const OutlineInputBorder(),
            ),

            obscureText: _isPasswordObscured,
            //validator: bloc.passwordValidator,
            //onSaved: (String value) {_userObj.password = value;}
          );
        },
      ),
    );
  }

  changePageToSignUp(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (BuildContext context) => SignUp()),
        (_) => false);
  }

  forgotPassword(al) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              al.tr("login.forgotPassword"),
              textAlign: TextAlign.right,
              style: Theme.of(context)
                  .textTheme
                  .body2
                  .copyWith(decoration: TextDecoration.underline),
            ),
          ),
          onTap: () {},
          splashColor: Palette.primary700,
        )
      ],
    );
  }

  continueButton(al, context) {
    return StreamBuilder(
      stream: _bloc.isLoadingController,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        return Container(
          margin: EdgeInsets.only(left: 50, right: 50),
          decoration: new BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Palette.primary,
                  Palette.primary2,
                ],
              ),
              borderRadius: new BorderRadius.all(const Radius.circular(20.0))),
          child: InkWell(
            onTap: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _bloc.submit(context);
              }
            },
            splashColor: Colors.white30,
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(12),
              child: snapshot.data
                  ? Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                      height: 20,
                      width: 20,
                    )
                  : Text(
                      al.tr("login.continue"),
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: Colors.white),
                    ),
            ),
          ),
        );
      },
    );
  }

  signupButton(al) {
    return Container(
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.end,
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(al.tr("login.notHaveAccount"),
              style: Theme.of(context)
                  .textTheme
                  .body2
                  .copyWith(fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: () {
              changePageToSignUp(context);
            },
            child: Text(
              al.tr("login.register"),
              style: Theme.of(context).textTheme.body2.copyWith(
                  color: Palette.primary,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _bloc = LoginBloc(AppLocalizations.of(context));
    var al = AppLocalizations.of(context);
    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
          body: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          new Container(
            height: 300.0,
            child: new Container(
              decoration: new BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      // Colors are easy thanks to Flutter's Colors class.
                      Palette.primary800,
                      Palette.primary700,
                      Palette.primary600,
                      Palette.primary400,
                    ],
                  ),
                  borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(20.0),
                      bottomRight: const Radius.circular(20.0))),
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 60, left: 50, right: 50),
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                ),
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              Card(
                elevation: 3,
                margin: EdgeInsets.only(top: 250, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        al.tr('login.title'),
                        style: Theme.of(context).textTheme.subhead.copyWith(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 10),
                      child: Form(
                        key: _formKey,
                        child: Theme(
                          data: ThemeData(primarySwatch: Colors.teal),
                          child: Column(
                            children: <Widget>[
                              emailField(al),
                              passwordField(al),
                              forgotPassword(al),
                              continueButton(al, context),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    signupButton(al),
                    Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Column(children: <Widget>[
                          Row(children: <Widget>[
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  child: Divider(
                                    color: Colors.black26,
                                    height: 36,
                                  )),
                            ),
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(left: 10.0),
                                  child: Divider(
                                    color: Colors.black26,
                                    height: 36,
                                  )),
                            ),
                          ]),
                        ])),
                  ],
                ),
              ),
            ],
            scrollDirection: Axis.vertical,
          ),
        ],
      )),
    );
  }
}
