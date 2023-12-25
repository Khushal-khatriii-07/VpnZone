import 'package:get/get.dart';
import 'package:vpn_basic_project/apiVpnGate/api_vpn_gate.dart';
import 'package:vpn_basic_project/appPreferances/appPrefrances.dart';

import '../allModel/vpn_info.dart';

class ControllerVpnLocation extends GetxController{
  List<VpnInfo> vpnFreeAvailableServersList = AppPrefrences.vpnList;

  final RxBool isLoadingNewLocations = false.obs;

  Future<void> retrieveVpnInformation() async{
    isLoadingNewLocations.value = true;

    vpnFreeAvailableServersList.clear();

    vpnFreeAvailableServersList = await ApiVpnGate.retrieveAllAvailableFreeVpnServers();

    isLoadingNewLocations.value = false;

  }
}