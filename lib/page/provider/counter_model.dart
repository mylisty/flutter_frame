import 'package:common_utils/common_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class Counter  with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;
  int get count => _count;
  CalculateInstallmentModel _calculateInstallmentModel;
  CalculateInstallmentModel get calculateInstallmentModel => _calculateInstallmentModel == null? CalculateInstallmentModel():_calculateInstallmentModel;
  void increment() {
    _count++;
    notifyListeners();
  }
  void changeCalculateInstallmentModel(CalculateInstallmentModel calculateInstallmentModel){
    _calculateInstallmentModel =  calculateInstallmentModel;
    LogUtil.e("aaaaaaaaaaaaa ${_calculateInstallmentModel.fqNum}");
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties // 可省略
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(IntProperty('count', count));
    properties.add(ObjectFlagProperty("calculateInstallmentModel",calculateInstallmentModel));
  }
}
class CalculateInstallmentModel {
  String perAmount;
  String currency;
  int fqNum = 0;
  String perFee;

  CalculateInstallmentModel({this.perAmount, this.currency, this.fqNum = 0, this.perFee});

  CalculateInstallmentModel.fromJson(Map<String, dynamic> json) {
    perAmount = json['perAmount'];
    currency = json['currency'];
    fqNum = json['fqNum'];
    perFee = json['perFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['perAmount'] = this.perAmount;
    data['currency'] = this.currency;
    data['fqNum'] = this.fqNum;
    data['perFee'] = this.perFee;
    return data;
  }
}
