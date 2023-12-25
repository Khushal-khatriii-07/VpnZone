import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/allModel/ip_details.dart';
import 'package:vpn_basic_project/allModel/network_ip_info.dart';
import 'package:vpn_basic_project/allWidgets/network_ip_info_widget.dart';
import 'package:vpn_basic_project/apiVpnGate/api_vpn_gate.dart';

class ConnectedNetworkIpInfoScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    final ipInfo = IpInfo.fromJson({}).obs;
    ApiVpnGate.retriveIpDetails(ipInformation: ipInfo);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          "Connected Network Ip Information",
          style: TextStyle(
            fontSize: 14
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          onPressed: (){
            ipInfo.value = IpInfo.fromJson({});
            ApiVpnGate.retriveIpDetails(ipInformation: ipInfo);
          },
          child: Icon(
            CupertinoIcons.refresh_circled,
          ),
        ),

      ),
      body: Obx(()=>ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(3),
        children: [
          //ip address
          NetworkIpInfoWidget(
              networkIpInfo: NetworkIpInfo(
                titleText: "Ip Address",
                subTitleText: ipInfo.value.query,
                iconData: Icon(
                  Icons.my_location_outlined,
                  color: Colors.redAccent,
                )
              ) ),

          //isp
          NetworkIpInfoWidget(
              networkIpInfo: NetworkIpInfo(
                  titleText: "Internet Service Provider",
                  subTitleText: ipInfo.value.internetServiceProvider,
                  iconData: Icon(
                    Icons.account_tree,
                    color: Colors.deepOrange,
                  )
              ) ),

          //Location
          NetworkIpInfoWidget(
              networkIpInfo: NetworkIpInfo(
                  titleText: "Location",
                  subTitleText: ipInfo.value.countryName.isEmpty ? "retrieving..." : "${ipInfo.value.cityName}, ${ipInfo.value.regionName}, ${ipInfo.value.countryName}",
                  iconData: Icon(
                    CupertinoIcons.location_solid,
                    color: Colors.green,
                  )
              ) ),

          //timezone
          NetworkIpInfoWidget(
              networkIpInfo: NetworkIpInfo(
                  titleText: "Time Zone",
                  subTitleText: ipInfo.value.timeZone,
                  iconData: Icon(
                    Icons.share_arrival_time,
                    color: Colors.cyan,
                  )
              ) ),

          //zipCode
          NetworkIpInfoWidget(
              networkIpInfo: NetworkIpInfo(
                  titleText: "Zip Code",
                  subTitleText: ipInfo.value.zipCode,
                  iconData: Icon(
                    CupertinoIcons.map_pin_ellipse,
                    color: Colors.purpleAccent,
                  )
              ) ),
        ],
      )),
    );
  }

}