import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teleport/blocs/SettingsBloc.dart';
import 'package:teleport/blocs/UserProfileBloc.dart';
import 'package:teleport/blocs/CommonSingleton.dart';
import 'package:teleport/common_utils/Palette.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  UserProfileBloc _bloc = UserProfileBloc();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _nickNameController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();
  File _image;
  bool initialised = false;

  @override
  Widget build(BuildContext context) {
    var al = AppLocalizations.of(context);
    var size = MediaQuery.of(context).size;
    var data = EasyLocalizationProvider.of(context).data;

   

    Future getImageFromCamera() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
      });
    }

    Future getImageFromGallary() async {
      var image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
      );
      setState(() {
        _image = image;
      });
    }

    Future<void> _optionsDialogBox() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return new CupertinoActionSheet(
              title: new Text(
                al.tr("image_picker.title"),
                style: Theme.of(context).textTheme.subtitle,
              ),
              actions: [
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: new Text(al.tr("image_picker.camera")),
                    onPressed: () {
                      getImageFromCamera();
                      Navigator.pop(
                        context,
                      );
                    }),
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: new Text(al.tr("image_picker.gallary")),
                    onPressed: () {
                      getImageFromGallary();

                      Navigator.pop(
                        context,
                      );
                    }),
              ],
            );
          });
    }

    var userImage = Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _optionsDialogBox();
          },
          child: commonSingleton.image != null
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(commonSingleton.image.value),
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  child: CircleAvatar(
                    child: _image == null
                        ? Icon(
                            Icons.person,
                            color: Color(0xFF8694A0),
                            size: 40,
                          )
                        : Image.file(
                            _image,
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                    backgroundColor: Color(0xFFEBEFF0),
                    radius: 40,
                  ),
//              decoration: new BoxDecoration(
//                  shape: BoxShape.circle,
//                  image: new DecorationImage(
//                      fit: BoxFit.fill,
//                      image: AssetImage("assets/images/user.png")))
                ),
        )
      ],
    );

    var email = StreamBuilder(
      stream: _bloc.email,
      builder: (context, AsyncSnapshot<String> snapshot) {
        _emailController.value =
            _emailController.value.copyWith(text: snapshot.data);
        return TextField(
            controller: _emailController,
            onChanged: _bloc.changeEmail,
//            validator: emailValidator,
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
              labelText: al.tr("edit_profile.email"),
              focusedBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary800, width: 1.3),
              ),
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary400, width: 1.0),
              ),
              border: const OutlineInputBorder(),
            ));
      },
    );

    var firstName = StreamBuilder(
      stream: _bloc.firstName,
      builder: (context, AsyncSnapshot<String> snapshot) {
        _firstnameController.value =
            _firstnameController.value.copyWith(text: snapshot.data);
        return TextField(
            controller: _firstnameController,
            onChanged: _bloc.changeFirstName,
//            validator: _bloc.emptyFieldValidator,
            keyboardType: TextInputType.text,
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
              labelText: al.tr("edit_profile.first_name"),
              focusedBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary800, width: 1.3),
              ),
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary400, width: 1.0),
              ),
              border: const OutlineInputBorder(),
            ));
      },
    );

    var lastName = StreamBuilder(
      stream: _bloc.lastName,
      builder: (context, AsyncSnapshot<String> snapshot) {
        _lastNameController.value =
            _lastNameController.value.copyWith(text: snapshot.data);
        return TextField(
            controller: _lastNameController,
            onChanged: _bloc.changeLastName,
//            validator: _bloc.emptyFieldValidator,
            keyboardType: TextInputType.text,
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
              labelText: al.tr("edit_profile.last_name"),
              focusedBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary800, width: 1.3),
              ),
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary400, width: 1.0),
              ),
              border: const OutlineInputBorder(),
            ));
      },
    );

    var nickName = StreamBuilder(
      stream: _bloc.nickName,
      builder: (context, AsyncSnapshot<String> snapshot) {
        _nickNameController.value =
            _nickNameController.value.copyWith(text: snapshot.data);
        return TextField(
            controller: _nickNameController,
            onChanged: _bloc.changeNickName,
//            validator: emptyFieldValidator,
            keyboardType: TextInputType.text,
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
              labelText: al.tr("edit_profile.nickname"),
              focusedBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary800, width: 1.3),
              ),
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary400, width: 1.0),
              ),
              border: const OutlineInputBorder(),
            ));
      },
    );

    var phoneNumber = StreamBuilder(
      stream: _bloc.phoneNumber,
      builder: (context, AsyncSnapshot<String> snapshot) {
        _phoneNumberController.value =
            _phoneNumberController.value.copyWith(text: snapshot.data);
        return TextField(
            controller: _phoneNumberController,
            onChanged: _bloc.changePhoneNumber,
//            validator: emptyFieldValidator,
            keyboardType: TextInputType.phone,
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
              labelText: al.tr("edit_profile.phone_number"),
              focusedBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary800, width: 1.3),
              ),
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: BorderSide(color: Palette.primary400, width: 1.0),
              ),
              border: const OutlineInputBorder(),
            ));
      },
    );

    var saveButton = StreamBuilder(
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
              _bloc.imageController.value = _image;
              _bloc.submit(context);
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

    return EasyLocalizationProvider(
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading:  GestureDetector(child: Icon(Icons.arrow_back_ios), onTap:(){
          Navigator.of(context).pop();
          },),
              expandedHeight: 100.0,
              floating: true,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(al.tr("edit_profile.title"),
                    style: Theme.of(context).textTheme.subtitle),
              ),
            ),
          ];
        },
        body: Row(
          children: <Widget>[
            getSizedBox(size.width * 0.15, 0.0),
            Container(
              width: size.width * 0.7,
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    getSizedBox(0.0, 20.0),
                    userImage,
                    getSizedBox(0.0, 20.0),
                    firstName,
                    getSizedBox(0.0, 20.0),
                    lastName,
                    getSizedBox(0.0, 20.0),
                    nickName,
                    getSizedBox(0.0, 20.0),
                    email,
                    getSizedBox(0.0, 20.0),
                    phoneNumber,
                    getSizedBox(0.0, 30.0),
                    saveButton
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
      data: data,
    );
  }

  Widget getSizedBox(width, height) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
