import 'dart:async';

import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:teleport/common_utils/CodeConstants.dart';
import 'package:teleport/common_utils/SharedPref.dart';
import 'package:teleport/models/UserModel.dart';
import 'package:teleport/ui/widgets/ErrorDialog.dart';
import 'package:validators/validators.dart';
import 'CommonSingleton.dart';
import '../network/Repository.dart';
import '../ui/pages/functionality/Home.dart';
import 'BlocBase.dart';

class LoginBloc extends BlocBase {
  AppLocalizations al;
  final repository = Repository();

  LoginBloc(this.al) {
    isLoadingController.sink.add(false);
  }

  final isLoadingController = BehaviorSubject<bool>();

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final isLoading = BehaviorSubject<bool>();

  Observable<bool> get isloading => isLoadingController.stream;

  Observable<String> get email =>
      _emailController.stream.transform(validateEmail);

  Observable<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@') & email.contains('.') & isEmail(email)) {
      sink.add(email);
    } else {
      sink.addError(CodeConstants.invalidEmailMessage);
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 5) {
      sink.add(password);
    } else {
      sink.addError(password.length == 0
          ? CodeConstants.emptyPasswordMessage
          : CodeConstants.passwordValidateMessage);
    }
  });

  String emailValidator(String inputValue) {
    if (inputValue.isEmpty) {
      return al.tr("error.emptyField");
    }

    if (!inputValue.contains('@') && !inputValue.contains('.')) {
      return al.tr("error.invalidEmail");
    }
    return null;
  }

  String passwordValidator(String inputValue) {
    if (inputValue.length < 5) {
      return al.tr("error.passwordLength");
    }

    return null;
  }

  submit(BuildContext context) {
    isLoadingController.sink.add(true);
    repository
        .login(_emailController.value, _passwordController.value)
        .then((value) {
      isLoadingController.sink.add(false);
      if (value.code == CodeConstants.CODE_SUCCESS) {
        getUserData(value.data, context);
      } else {
        ErrorDialog(context, value.data);
      }
    });
  }

  getUserData(uid, context) {
    repository.getProfile(uid).then((res) {
      if (res.code == CodeConstants.CODE_SUCCESS) {
        var user = UserModel.fromJson(res.data);
        commonSingleton.updateProfile(user);
        commonSingleton.saveLocal(user);

        SharedPref().save(CodeConstants.USER_ID, uid).then((uid) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => Home()),
              (_) => false);
        });
      } else {
        ErrorDialog(
          context,
          res.data,
        );
      }
    });
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    isLoadingController.close();
  }

  void navigateToHome(context, uid) {
    SharedPref().save(CodeConstants.USER_ID, uid).then((uid) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Home()),
          (_) => false);
    });
  }
}
