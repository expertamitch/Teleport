import 'package:flutter/cupertino.dart';
import 'package:teleport/models/ErrorModel.dart';
import 'package:teleport/network/Repository.dart';
import 'package:teleport/ui/widgets/ErrorDialog.dart';

import 'BlocBase.dart';

class AddCardBloc extends BlocBase {
  Repository repository = Repository();

  @override
  void dispose() {}

  saveCard(String token, BuildContext context) {
    repository.saveCard(token).then((res) {
//      isLoadingController.sink.add(false);
    }).catchError((error) {
//      isLoadingController.sink.add(false);
      ErrorDialog(context, error.message);
    });
  }
}
