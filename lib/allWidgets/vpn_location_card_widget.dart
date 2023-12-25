import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/all_controllers/all_controllers.dart';
import 'package:vpn_basic_project/appPreferances/appPrefrances.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/vpnEngine/VpnEngine.dart';

import '../allModel/vpn_info.dart';

class VpnLocationCardWidget extends StatelessWidget{

  final VpnInfo vpnInfo;

  VpnLocationCardWidget({super.key, required this.vpnInfo});

  String FormatSpeedBytes(int speedBytes, int decimals){
    if(speedBytes <= 0){
      return "0 B";
    }

    const suffixesTitle = ["Bps", "Kbps", "Gbps", "Tbps"];

    var speedTitleIndex = (log(speedBytes) / log(1024)).floor();

    return "${(speedBytes / pow(1024, speedTitleIndex)).toStringAsFixed(decimals)} ${suffixesTitle[speedTitleIndex]}";
  }

  @override
  Widget build(BuildContext context) {

    sizeOfScreen = MediaQuery.of(context).size;
    final homeController = Get.find<AllController>();

    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: sizeOfScreen.height * .01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: (){
          homeController.vpnInfo.value = vpnInfo;
          AppPrefrences.vpnInfoObj = vpnInfo;
          Get.back();

          if(homeController.vpnConnectionState.value == VpnEngine.vpnConnectedNow){
            VpnEngine.stopVpnNow();

            Future.delayed(Duration(seconds: 3), ()=> homeController.connectToVpnNow());
          }
          else{
            homeController.connectToVpnNow();
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          leading: Container(
            padding: EdgeInsets.all(0.5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset("countryFlags/${vpnInfo.countryShortName.toLowerCase()}.png",
              height: 40,
              width: sizeOfScreen.width*.15,
              fit : BoxFit.cover,
            ),
          ),

          //country name
          title: Text(vpnInfo.countryLongName),

          //vpn speed
          subtitle: Row(
            children: [
              Icon(
                Icons.shutter_speed,
                color: Colors.lightBlueAccent,
                size: 20,
              ),
              SizedBox(width: 4,),
              Text(
                FormatSpeedBytes(vpnInfo.speed, 2),
                style: TextStyle(
                  fontSize: 13,
                )
              ),

            ],
          ),

          //number of sessions
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vpnInfo.vpnSessionNum.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).lightTextColor
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Icon(CupertinoIcons.person_2, color: Colors.lightBlueAccent),
            ],

          ),
        ),
      ),
    );
  }

}