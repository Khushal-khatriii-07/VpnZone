import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/allWidgets/vpn_location_card_widget.dart';
import 'package:vpn_basic_project/all_controllers/controller_vpn_location.dart';

class AvailableVpnServersLocation extends StatelessWidget{

  final vpnLocationController = ControllerVpnLocation();

  @override
  Widget build(BuildContext context) {
    if(vpnLocationController.vpnFreeAvailableServersList.isEmpty){
      vpnLocationController.retrieveVpnInformation();
    }
    return Obx(()=>Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          "Vpn Locations ("+vpnLocationController.vpnFreeAvailableServersList.length.toString()+")",
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 10, bottom: 10),
        child: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          onPressed: (){
            vpnLocationController.retrieveVpnInformation();
          },
          child: Icon(
            CupertinoIcons.refresh_circled,
            size: 40,
          ),
        ),
      ),
      body: vpnLocationController.isLoadingNewLocations.value
          ? loadingUiWidget()
          : vpnLocationController.vpnFreeAvailableServersList.isEmpty
          ? noVpnServerFoundUiWidget()
          : vpnAvailableServerData(),
    ));
  }

  loadingUiWidget() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
          ),

          SizedBox(
            height: 8,
          ),

          Text(
            "Gathering Free Vpn Locations....",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }

  noVpnServerFoundUiWidget() {
    return Center(
      child: Text(
        "No Vpn Found!! Try Again..",
        style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  vpnAvailableServerData() {
    return ListView.builder(
      itemCount: vpnLocationController.vpnFreeAvailableServersList.length,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(3),
      itemBuilder: (context, index){
        return VpnLocationCardWidget(vpnInfo: vpnLocationController.vpnFreeAvailableServersList[index]);
      },
    );
  }
}