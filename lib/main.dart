import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/all_screens/HomeScreen.dart';
import 'package:vpn_basic_project/appPreferances/appPrefrances.dart';


late Size sizeOfScreen;
Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.lightBlueAccent,
  ));
  WidgetsFlutterBinding.ensureInitialized();

  await AppPrefrences.initHive();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Free Vpn',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              centerTitle: true, elevation: 3
          ),
      ),
      themeMode: AppPrefrences.isModeDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
              centerTitle: true, elevation: 3
          ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

extension AppTheme on ThemeData{

  Color get lightTextColor => AppPrefrences.isModeDark ? Colors.white70 : Colors.black45;
  Color get bottomNavigationColor => AppPrefrences.isModeDark ? Colors.white12 : Colors.redAccent;
}