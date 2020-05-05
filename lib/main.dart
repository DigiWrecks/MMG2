import 'package:flutter/material.dart';
import 'package:mydoctor/screens/admin/admin-home.dart';
import 'package:mydoctor/screens/admin/admin-login.dart';
import 'package:mydoctor/screens/home.dart';
import 'package:mydoctor/screens/login.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
  OneSignal.shared.init(
      "e87f5b22-5db7-4c61-83bf-e6e812ebae07",
      iOSSettings: {
        OSiOSSettings.autoPrompt: false,
        OSiOSSettings.inAppLaunchUrl: true
      }
  );
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String email;
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'GoogleSans',
        primaryColor: Color(0xff0D47A1),
        accentColor: Color(0xff90CAF9)
      ),
      home: email==null?LogIn():email=='admin'?AdminHome():Home(),
      //home: AdminHome(),
    );
  }
}
