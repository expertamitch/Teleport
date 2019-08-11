import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:teleport/blocs/SignupBloc.dart';
import 'package:teleport/common_utils/Palette.dart';

import 'Login.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  SignUpBloc _bloc;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Widget emailField(al) {
    return StreamBuilder(
      stream: _bloc.email,
      builder: (context, AsyncSnapshot<String> snapshot) {
        _emailController.value =
            _emailController.value.copyWith(text: snapshot.data);
        return TextFormField(
            onFieldSubmitted: (val) {
//              _formKey.currentState.save();
              _emailFocusNode.unfocus();
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            controller: _emailController,
            onSaved: _bloc.changeEmail,
            validator: _bloc.emailValidator,
            keyboardType: TextInputType.emailAddress,
            focusNode: _emailFocusNode,
            textInputAction: TextInputAction.next,
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
              labelText: al.tr("signUp.email"),
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
    return StreamBuilder(
      stream: _bloc.password,
      builder: (context, AsyncSnapshot<String> snapshot) {
        _passwordController.value =
            _passwordController.value.copyWith(text: snapshot.data);
        return TextFormField(
          validator: _bloc.passwordValidator,
          focusNode: _passwordFocusNode,
          controller: _passwordController,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (val) {
            _passwordFocusNode.unfocus();
            FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
            _formKey.currentState.save();
          },
          onSaved: _bloc.changePassword,
          textAlign: TextAlign.start,
          style: new TextStyle(
              fontFamily: "SourceSansPro",
              color: Colors.black,
              height: 0.2,
              fontSize: 14),
          obscureText: true,
          decoration: InputDecoration(
            fillColor: Colors.white,
            labelStyle: TextStyle(color: Colors.black, fontSize: 14),
            labelText: al.tr('signUp.password'),
            errorText: snapshot.error,
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
        );
      },
    );
  }

  Widget confirmPasswordField(al) {
    return StreamBuilder(
      stream: _bloc.confirmPassword,
      builder: (context, AsyncSnapshot<String> snapshot) {
        _confirmPasswordController.value =
            _confirmPasswordController.value.copyWith(text: snapshot.data);
        return TextFormField(
          validator: _bloc.confirmPasswordValidator,
          focusNode: _confirmPasswordFocusNode,
          controller: _confirmPasswordController,
          onFieldSubmitted: (val) {
            _confirmPasswordFocusNode.unfocus();
            //  _formKey.currentState.save();
          },
          onSaved: _bloc.changeConfirmPassword,
          textAlign: TextAlign.start,
          obscureText: true,
          style: new TextStyle(
              fontFamily: "SourceSansPro",
              color: Colors.black,
              height: 0.2,
              fontSize: 14),
          decoration: InputDecoration(
            fillColor: Colors.white,
            labelStyle: TextStyle(color: Colors.black, fontSize: 14),
            labelText: al.tr('signUp.confirmPassword'),
            errorText: snapshot.error,
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
        );
      },
    );
  }

  changePageToLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => Login()),
        (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    _bloc = SignUpBloc(AppLocalizations.of(context));
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
                          al.tr('signUp.title'),
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
                                Container(
                                    margin: EdgeInsets.only(top: 16, bottom: 8),
                                    child: passwordField(al)),

                                Container(
                                    margin: EdgeInsets.only(top: 16, bottom: 8),
                                    child: confirmPasswordField(al)),
                                //                        submitButton(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder(
                        stream: _bloc.isloading,
                        builder: (context, AsyncSnapshot<bool> snapshot) {
                          return Container(
                            margin: EdgeInsets.only(left: 50, right: 50),
                            decoration: new BoxDecoration(
                                gradient: LinearGradient(
                                  //                          begin: Alignment.topRight,
//                          end: Alignment.bottomLeft,
                                  colors: [
                                    // Colors are easy thanks to Flutter's Colors class.
                                    Palette.primary,
                                    Palette.primary2,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[500],
                                    offset: Offset(0.0, 1.5),
                                    blurRadius: 1.5,
                                  ),
                                ],
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(20.0),
                                    topRight: const Radius.circular(20.0),
                                    bottomLeft: const Radius.circular(20.0),
                                    bottomRight: const Radius.circular(20.0))),
                            child: Container(
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.all(12),
                                child: InkWell(
                                  onTap: () {
                                    _formKey.currentState.save();
                                    if (_formKey.currentState.validate())
                                      _bloc.registerViaEmail(
                                          _formKey, _scaffoldKey, context);
                                  },
                                  child: Center(
                                    child: snapshot.data
                                        ? Container(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                            ),
                                            height: 20,
                                            width: 20,
                                          )
                                        : Text(
                                            al.tr("signUp.register"),
                                            style: Theme.of(context)
                                                .textTheme
                                                .button,
                                          ),
                                  ),
                                )),
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        //padding: EdgeInsets.only(top: 80),
                        child: Flex(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(al.tr("signUp.alreadyHaveAccount"),
                                style: Theme.of(context)
                                    .textTheme
                                    .body2
                                    .copyWith(fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () {
                                changePageToLogin(context);
                              },
                              child: Text(
                                al.tr("signUp.login"),
                                style: Theme.of(context)
                                    .textTheme
                                    .body2
                                    .copyWith(
                                        color: Palette.primary,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
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
//              Padding(
//                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
//                child: Column(
//                  children: <Widget>[
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Container(
//                          width: MediaQuery.of(context).size.width / 2.5,
//                          height: 50,
//                          child: RaisedButton(
//                              color: Colors.blue.shade700,
//                              onPressed: () {
//                                _bloc.initiateFacebookLogin(
//                                    _scaffoldKey, context);
//                              },
//                              child: Text(
//                                'Facebook',
//                                style: Theme.of(context)
//                                    .textTheme
//                                    .subtitle
//                                    .copyWith(fontSize: 18),
//                              ),
//                              shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(25.0))),
//                        ),
//                        Container(
//                          width: MediaQuery.of(context).size.width / 2.5,
//                          height: 50,
//                          child: RaisedButton(
//                              color: Colors.red.shade500,
//                              onPressed: () {
//                                _bloc.initiateGoogleLogin(
//                                    _scaffoldKey, context);
//                              },
//                              child: Text(
//                                'Google',
//                                style: Theme.of(context)
//                                    .textTheme
//                                    .subtitle
//                                    .copyWith(fontSize: 18),
//                              ),
//                              shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(25.0))),
//                        ),
//                      ],
//                    )
//                  ],
//                ),
//              )
                    ],
                  ),
                )
              ],
              scrollDirection: Axis.vertical,
            ),
          ],
        ),
      ),
    );
  }
}
