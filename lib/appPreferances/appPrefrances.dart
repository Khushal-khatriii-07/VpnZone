import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:vpn_basic_project/allModel/vpn_info.dart';

class AppPrefrences{
  static late Box boxOfData;

  static Future<void> initHive() async{

    await Hive.initFlutter();

    boxOfData = await Hive.openBox("data");
  }

  // saving choice of about theme selection
  static bool get isModeDark => boxOfData.get("isModeDark") ?? false;
  static set isModeDark(bool value) => boxOfData.put("isModeDark", value);

  //save for single country data details
  static VpnInfo get vpnInfoObj => VpnInfo.fromJson(jsonDecode(boxOfData.get("vpn") ?? '{}'));
  static set vpnInfoObj(VpnInfo value) => boxOfData.put("vpn", jsonEncode(value));

  //save for all country data details
  static List<VpnInfo> get vpnList {
    List<VpnInfo> tmpVpnList = [];
    final dataVpn = jsonDecode(boxOfData.get("vpnList") ?? '[]' );
    for(var data in dataVpn){
      tmpVpnList.add(VpnInfo.fromJson(data));
    }
    return tmpVpnList;
  }
  static set vpnList(List<VpnInfo> valueList) => boxOfData.put('vpnList', jsonEncode(valueList));
}