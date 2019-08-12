import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:teleport/common_utils/CodeConstants.dart';
import 'package:teleport/models/ErrorModel.dart';
import 'package:teleport/models/RideParamsModel.dart';
import 'package:teleport/network/Repository.dart';
import 'package:teleport/ui/pages/functionality/AddCardDialog.dart';
import 'package:teleport/ui/pages/functionality/ContactSupportError.dart';
import 'package:teleport/ui/pages/functionality/RideInProgress.dart';
import 'package:teleport/ui/widgets/ErrorDialog.dart';

import 'BlocBase.dart';

class RequestRideSheetBloc extends BlocBase {
  RequestRideSheetBloc() {
    isLoadingController.sink.add(false);
  }

  final repository = Repository();

  final isLoadingController = BehaviorSubject<bool>();

  Observable<bool> get isloading => isLoadingController.stream;

  callCreateRide(RideParamsModel rideParamsModel, BuildContext context) {
    isLoadingController.sink.add(true);

    repository.createRide(rideParamsModel).then((res) {
      isLoadingController.sink.add(false);
      Navigator.pop(context);
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => RideInProgress()));
    }).catchError((error) {
      isLoadingController.sink.add(false);

      ErrorModel errorModel = ErrorModel.fromJson(error.details);

      switch (errorModel.code) {
        case 1:
          AddCardDialog(context, error.message);
          break;

        case 2:
//          TODO handle with paying balance, show dialog to confirmation for payment
          ErrorDialog(context, error.message);
          break;

        case 4:
//          driver is not available in this case.
          ErrorDialog(context, error.message);
          break;

        case 11:
//          normal error dialog to contact support
          ContactSupportDialog(context, error.message);
          break;
      }
    });
  }

  @override
  void dispose() {
    isLoadingController.close();
  }
}
/*
*  code: 1
*  No payment option.This action requires a valid payment card
*
*  code: 11
*  No such customer. Please contact Teleport Support
*
*  code 11
*  Customer data is deleted or corrupted. Please contact Teleport Support
*
*  code: 2, balance: balance, currency: currency
*  You have outstanding balance of {balance}. '    'Please pay the amount due before requesting a ride
*
*  code 4
*  Selected driver is not active anymore, cannot complete request.
* */
