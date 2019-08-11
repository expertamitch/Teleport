import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rxdart/rxdart.dart';
import 'package:teleport/common_utils/CodeConstants.dart';
 import 'package:teleport/common_utils/SharedPref.dart';
import 'package:teleport/models/RideParamsModel.dart';
import 'package:teleport/models/UserModel.dart';
import 'package:teleport/network/Repository.dart';
 import 'package:frideos_core/frideos_core.dart';
import 'package:teleport/ui/widgets/ErrorDialog.dart';
import 'CommonSingleton.dart';
import 'BlocBase.dart';

class RideSettingsBloc extends BlocBase {
  final repository = Repository();

  RideSettingsBloc() {
    isLoadingController.sink.add(false);
    _minimumRideLengthController.sink.add(commonSingleton.minLength.value);
    _minimumRidePriceController.sink.add(commonSingleton.minPrice.value);
    _nextTimeBlocPriceController.sink.add(commonSingleton.nextBlocPrice.value);
    _nextTimeBlocLengthController.sink.add(commonSingleton.nextBlocLength.value);
    currencyController.value = commonSingleton.currency.value;
  }

  final isLoadingController = BehaviorSubject<bool>();

  final _minimumRideLengthController = BehaviorSubject<String>();
  final _minimumRidePriceController = BehaviorSubject<String>();
  final _nextTimeBlocLengthController = BehaviorSubject<String>();
  final _nextTimeBlocPriceController = BehaviorSubject<String>();
  final currencyController = StreamedValue<String>();

  Observable<bool> get isloading => isLoadingController.stream;

  Observable<String> get minimumRideLength =>
      _minimumRideLengthController.stream;

  Observable<String> get minimumRidePrice => _minimumRidePriceController.stream;

  Observable<String> get nextTimeBlocLength =>
      _nextTimeBlocLengthController.stream;

  Observable<String> get nextTimeBlocPrice =>
      _nextTimeBlocPriceController.stream;

  Function(String) get changeMinimumPrice =>
      _minimumRidePriceController.sink.add;

  Function(String) get changeMinimumlength =>
      _minimumRideLengthController.sink.add;

  Function(String) get changeNextTimeBlocLength =>
      _nextTimeBlocLengthController.sink.add;

  Function(String) get changeNextTimeBlocPrice =>
      _nextTimeBlocPriceController.sink.add;

//  String fieldValidator(String inputValue) {
//    if (inputValue.isEmpty) {
//      return al.tr("error.emptyField");
//    }
//    return null;
//  }

  @override
  void dispose() {
    _minimumRideLengthController.close();
    _minimumRidePriceController.close();
    _nextTimeBlocLengthController.close();
    _nextTimeBlocPriceController.close();
    currencyController.dispose();
    isLoadingController.close();
  }

  void submit(BuildContext context) {
    isLoadingController.sink.add(true);
    UserModel userModel = commonSingleton.getUserModel();

    userModel.rideParams.minRideLength = _minimumRideLengthController.value;
    userModel.rideParams.minRidePrice = _minimumRidePriceController.value;
    userModel.rideParams.nextTimeBlocPrice = _nextTimeBlocPriceController.value;
    userModel.rideParams.nextTimeBlocLength =
        _nextTimeBlocLengthController.value;
    userModel.rideParams.currency = currencyController.value;

    repository.setRideParams(userModel.id, userModel).then((res) {
      isLoadingController.sink.add(false);

      if (res.code == CodeConstants.CODE_SUCCESS) {
        saveLocal(userModel, context);
      } else {
        ErrorDialog(
          context,
          res.data,
        );
        isLoadingController.sink.add(false);
      }
    });
  }

  saveLocal(UserModel userModel, context) {
    commonSingleton.saveLocal(userModel).then((res) {
      commonSingleton.updateProfile(userModel);
      isLoadingController.sink.add(false);
      Navigator.of(context).pop();
    });

    /* SharedPref().get(PrefKeys.user).then((user) {
      UserModel userObj = UserModel.stringToObject(user);
      userObj.rideParams = rideParamsModel;
      profileBloc.updateRideParams(rideParamsModel);
      SharedPref().save(PrefKeys.user, userObj.toString()).then((val) {
      });
    });*/
  }
}
