import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vpn_basic_project/allModel/network_ip_info.dart';
import 'package:vpn_basic_project/main.dart';

class NetworkIpInfoWidget extends StatelessWidget{

  final NetworkIpInfo networkIpInfo;

  NetworkIpInfoWidget({
    super.key,
    required this.networkIpInfo,
  });

  @override
  Widget build(BuildContext context) {
    sizeOfScreen = MediaQuery.of(context).size;

    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: sizeOfScreen.height*.01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
        ),
        leading: Icon(
          networkIpInfo.iconData.icon,
          size: networkIpInfo.iconData.size ?? 28,
        ),
        title: Text(
          networkIpInfo.titleText,
        ),
        subtitle: Text(
          networkIpInfo.subTitleText
        ),
      ),

    );
  }

}