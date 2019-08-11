import 'package:teleport/common_utils/CodeConstants.dart';
import 'package:teleport/common_utils/SharedPref.dart';
import 'package:teleport/models/UserModel.dart';
import 'BlocBase.dart';
import 'CommonSingleton.dart';

class MainBloc extends BlocBase {
  MainBloc() {
    SharedPref().get(CodeConstants.USER).then((user) {
      if (user != null) {
        var userObj = UserModel.stringToObject(user);
        commonSingleton.updateProfile(userObj);
      }
    });

    SharedPref().get(CodeConstants.TOKEN).then((token) {
      commonSingleton.token.value = token;
    });
  }

  @override
  void dispose() {}
}
