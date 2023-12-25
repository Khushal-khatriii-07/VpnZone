import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vpn_basic_project/allModel/vpn_info.dart';
import 'package:vpn_basic_project/allModel/vpn_status.dart';
import 'package:vpn_basic_project/allWidgets/CustomWidgets.dart';
import 'package:vpn_basic_project/allWidgets/timer_widget.dart';
import 'package:vpn_basic_project/all_controllers/all_controllers.dart';
import 'package:vpn_basic_project/all_screens/available_vpn_servers_Location_screen.dart';
import 'package:vpn_basic_project/all_screens/connected_network_ip_info_screen.dart';
import 'package:vpn_basic_project/appPreferances/appPrefrances.dart';
import 'package:vpn_basic_project/vpnEngine/VpnEngine.dart';

import '../main.dart';


class HomeScreen extends StatelessWidget{

  final homeController = Get.put(AllController());


  @override
  Widget build(BuildContext context) {
    VpnEngine.snapshotVpnStage().listen((event) {
      homeController.vpnConnectionState.value = event;

    });

    sizeOfScreen = MediaQuery.of(context).size;

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text("Free VPN"),
          leading: IconButton(
            onPressed: (){
              Get.to(()=> ConnectedNetworkIpInfoScreen());
            },
            icon: Icon(Icons.perm_device_info),
          ),
          actions: [
            IconButton(
                onPressed: (){
                     Get.changeThemeMode(
                       AppPrefrences.isModeDark ? ThemeMode.light : ThemeMode.dark,
                     );
                     AppPrefrences.isModeDark = !AppPrefrences.isModeDark;
                },
                icon: Icon(CupertinoIcons.brightness))
          ],
        ),
        bottomNavigationBar: LocationBottomNavigationBar(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //2 Widgets for
            //Location + Ping
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomWidgets(
                    titleText: homeController.vpnInfo.value.countryLongName.isEmpty
                        ? "Location"
                        : homeController.vpnInfo.value.countryLongName,
                    subtitle: "Free",
                    roundWidgetWithIcon: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 30,
                      child: homeController.vpnInfo.value.countryLongName.isEmpty ? Icon(CupertinoIcons.flag_circle,
                        color: Colors.white,
                      ): null,
                      backgroundImage: homeController.vpnInfo.value.countryLongName.isEmpty
                          ? null
                          : AssetImage("countryFlags/${homeController.vpnInfo.value.countryShortName.toLowerCase()}.png"),
                    )
                ),

                CustomWidgets(
                    titleText: homeController.vpnInfo.value.countryLongName.isEmpty
                        ?" 60 ms "
                        : homeController.vpnInfo.value.ping.toString() +' ms',
                    subtitle: "Ping",
                    roundWidgetWithIcon: CircleAvatar(
                      backgroundColor: Colors.black54,
                      radius: 30,
                      child: Icon(
                        Icons.graphic_eq,
                        color: Colors.white,
                      ),
                    )
                )
              ],
            ),),
            SizedBox(height: 60,),
            // middle button
            // connect or disconnect
            Obx(() => vpnRoundButton()),

            SizedBox(height: 20,),

            Obx(() => TimerWidget(initTimerNow: homeController.vpnConnectionState.value == VpnEngine.vpnConnectedNow,)),

            SizedBox(height: 60,),

            //2 Widgets for
            //Location + Ping
            StreamBuilder<VpnStatus?>(
              initialData: VpnStatus(),
              stream: VpnEngine.snapshotVpnStatus(),
              builder: (context, datasnapshot){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomWidgets(
                        titleText: "${datasnapshot.data?.byteIn??'0 kbps'}",
                        subtitle: "Download",
                        roundWidgetWithIcon: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 30,
                          child: Icon(
                            Icons.arrow_circle_down_outlined,
                            color: Colors.white,
                          ),
                        )
                    ),

                    CustomWidgets(
                        titleText: "${datasnapshot.data?.byteOut??'0 kbps'}",
                        subtitle: "Upload",
                        roundWidgetWithIcon: CircleAvatar(
                          backgroundColor: Colors.purple,
                          radius: 30,
                          child: Icon(
                            Icons.arrow_circle_up,
                            color: Colors.white,
                          ),
                        )
                    )
                  ],
                );
              },
            ),
          ],
        )
      );
  }

  LocationBottomNavigationBar(BuildContext context) {
    return SafeArea(
        child: Semantics(
          button: true,
          child: InkWell(
            onTap: (){
              Get.to(()=> AvailableVpnServersLocation());
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: sizeOfScreen.width * 0.098),
              height: 60,
              color: Colors.black54,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.flag_circle,
                    size: 36,
                  ),
                  SizedBox( width: 13,),
                  Text(
                    "Select Country/ Location",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      fontSize: 16.3,
                    ),
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black54,
                      size: 26,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }

  vpnRoundButton() {
    return Column(
      children: [
        Semantics(
          button: true,
          child: InkWell(
            onTap: (){
              homeController.connectToVpnNow();
            },
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: homeController.getRoundVpnButtonColor.withOpacity(.2),
              ),
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: homeController.getRoundVpnButtonColor.withOpacity(.3),
                ),
                child: Container(
                  height: sizeOfScreen.height * 0.14,
                  width: sizeOfScreen.width * 0.3,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: homeController.getRoundVpnButtonColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.power_settings_new_rounded, color: Colors.white,),
                      SizedBox(height: 15,),
                      Text(
                        homeController.getRoundVpnButtonText,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

}
