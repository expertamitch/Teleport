import 'package:teleport/common_utils/CodeConstants.dart';

class ErrorModel {
  int _code;

  ErrorModel({int code}) {
    this._code = code;
  }

  int get code => _code;

  set code(int code) => _code = code;

  ErrorModel.fromJson(Map<dynamic, dynamic> json) {
    _code = json[CodeConstants.CODE_];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[CodeConstants.CODE_] = this._code;
    return data;
  }
}
