import 'dart:io';

import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rxdart/rxdart.dart';
import 'package:teleport/common_utils/CodeConstants.dart';
 import 'package:teleport/common_utils/SharedPref.dart';
import 'package:teleport/models/CommonResponseModel.dart';
import 'package:teleport/models/UserModel.dart';
import 'package:teleport/network/Repository.dart';
 import 'package:frideos_core/frideos_core.dart';
import 'package:teleport/ui/widgets/ErrorDialog.dart';
import 'CommonSingleton.dart';
import 'BlocBase.dart';

class UserProfileBloc extends BlocBase {
  final repository = Repository();

  UserProfileBloc() {
    isLoadingController.sink.add(false);
    _emailController.sink.add(commonSingleton.email.value);
    _firstnameController.sink.add(commonSingleton.firstName.value);
    _lastNameController.sink.add(commonSingleton.lastName.value);
    _nickNameController.sink.add(commonSingleton.nickName.value);
    _phoneNumberController.sink.add(commonSingleton.phoneNumber.value);
  }

  final isLoadingController = BehaviorSubject<bool>();
  final _emailController = BehaviorSubject<String>();
  final _firstnameController = BehaviorSubject<String>();
  final _lastNameController = BehaviorSubject<String>();
  final _nickNameController = BehaviorSubject<String>();
  final _phoneNumberController = BehaviorSubject<String>();
  final imageController = StreamedValue<File>();

  Observable<bool> get isloading => isLoadingController.stream;

  Observable<String> get email => _emailController.stream;

  Observable<String> get firstName => _firstnameController.stream;

  Observable<String> get lastName => _lastNameController.stream;

  Observable<String> get nickName => _nickNameController.stream;

  Observable<String> get phoneNumber => _phoneNumberController.stream;

  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changeFirstName => _firstnameController.sink.add;

  Function(String) get changeLastName => _lastNameController.sink.add;

  Function(String) get changeNickName => _nickNameController.sink.add;

  Function(String) get changePhoneNumber => _phoneNumberController.sink.add;

  String emailValidator(String inputValue) {
    if (inputValue.isEmpty) {
      return "error.emptyField";
    }

    if (!inputValue.contains('@') && !inputValue.contains('.')) {
      return "error.invalidEmail";
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.close();
    isLoadingController.close();
    _firstnameController.close();
    _lastNameController.close();
    _phoneNumberController.close();
    _nickNameController.close();
  }

  void submit(BuildContext context) {
    isLoadingController.sink.add(true);

    SharedPref().get(CodeConstants.USER_ID).then((uid) {
      if (imageController.value != null) {
        uploadImage(uid).then((res) {
          if (res.code == CodeConstants.CODE_SUCCESS) {
            updateProfile(context, uid, res.data).then((res) {
              isLoadingController.sink.add(false);
              if (res.code == CodeConstants.CODE_SUCCESS) {
                Navigator.of(context).pop();
              } else {
                ErrorDialog(
                  context,
                  res.data,
                );
              }
            });
          } else {
            isLoadingController.sink.add(false);
            ErrorDialog(
              context,
              res.data,
            );
          }
        });
      } else {
        updateProfile(context, uid, null).then((res) {
          isLoadingController.sink.add(false);

          if (res.code == CodeConstants.CODE_SUCCESS) {
            Navigator.of(context).pop();
          } else {
            ErrorDialog(
              context,
              res.data,
            );
          }
        });
      }
    });
  }

  Future<CommonResponseModel> updateProfile(context, uid, imageUrl) {
    var userObject = UserModel();
    userObject.id = uid;
    userObject.email = _emailController.value;
    userObject.nickName = _nickNameController.value;
    userObject.firstName = _firstnameController.value;
    userObject.lastName = _lastNameController.value;
    userObject.phoneNumber = _phoneNumberController.value;
    userObject.image = imageUrl;

    saveLocal(userObject, context);
    commonSingleton.updateProfile(userObject);
    return repository.updateUser(uid, userObject);
  }

  Future<CommonResponseModel> uploadImage(uid) {
    print(imageController.value.path.split("/").last.split(".")[1]);
    return repository.updateImage(uid, imageController.value.path,
        imageController.value.path.split("/").last.split(".")[1]);
  }

  Future<void> saveLocal(UserModel userObj, context) {
    return SharedPref().save(CodeConstants.USER, userObj.toString()).then((res) {
      return;
    });
  }
}
