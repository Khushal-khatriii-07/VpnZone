import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/allModel/vpn_configuration.dart';
import 'package:vpn_basic_project/appPreferances/appPrefrances.dart';
import 'package:vpn_basic_project/vpnEngine/VpnEngine.dart';
import '../allModel/vpn_info.dart';

class AllController extends GetxController{
  final Rx<VpnInfo> vpnInfo = AppPrefrences.vpnInfoObj.obs;
  final vpnConnectionState = VpnEngine.vpnDisconnectedNow.obs;

  void connectToVpnNow() async {
    if(vpnInfo.value.base64OpenVpnConfigurationData.isEmpty){
      Get.snackbar("Country / Location", "Please select country / location first");

      return;
    }

    //disconnect
    if(vpnConnectionState.value == VpnEngine.vpnDisconnectedNow){
      final dataConfigVpn = Base64Decoder().convert(vpnInfo.value.base64OpenVpnConfigurationData);
      final configuration = Utf8Decoder().convert(dataConfigVpn);

      final vpnConfiguration = VpnConfiguration(
          userName: 'vpn',
          password: 'vpn',
          countryName: vpnInfo.value.countryLongName,
          config: configuration
      );

      await VpnEngine.startVpnNow(vpnConfiguration);
    }
    else{
      await VpnEngine.stopVpnNow();
    }
  }

  Color get getRoundVpnButtonColor{
    switch(vpnConnectionState.value){
      case VpnEngine.vpnDisconnectedNow:
        return Colors.lightBlueAccent;
      case VpnEngine.vpnConnectedNow:
        return Colors.green;
      default :
        return Colors.orangeAccent;
    }
  }

  String get getRoundVpnButtonText{
    switch(vpnConnectionState.value){
      case VpnEngine.vpnDisconnectedNow:
        return "Tap To Connect";
      case VpnEngine.vpnConnectedNow:
        return "Disconnect";
      default :
        return "Connecting....";
    }
  }
}