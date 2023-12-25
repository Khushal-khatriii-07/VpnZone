import 'package:flutter/material.dart';
import 'package:vpn_basic_project/main.dart';

class CustomWidgets extends StatelessWidget{
  final String titleText;
  final String subtitle;
  final Widget roundWidgetWithIcon;

  CustomWidgets({
    super.key,
    required this.titleText,
    required this.subtitle,
    required this.roundWidgetWithIcon,
  });

  @override
  Widget build(BuildContext context) {
    sizeOfScreen = MediaQuery.of(context).size;
    return SizedBox(
      width: sizeOfScreen.width * 0.46,
      child: Column(
        children: [

          roundWidgetWithIcon,

          SizedBox(
            height: 4,
          ),

          Text(
            titleText,
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),

          SizedBox(
            height: 4,
          ),

          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

}