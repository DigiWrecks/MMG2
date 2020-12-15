import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mydoctor/screens/admin/admin-home.dart';
import 'package:mydoctor/screens/home.dart';
import 'package:mydoctor/screens/privacy-policy.dart';
import 'package:mydoctor/screens/update.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });

  OneSignal.shared.init(
      //"e87f5b22-5db7-4c61-83bf-e6e812ebae07",
      "2d0f6848-b8dc-43f3-9293-3e213e4fcbc2",
      iOSSettings: {
        OSiOSSettings.autoPrompt: true,
        OSiOSSettings.inAppLaunchUrl: true
      });
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

  getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String buildNumber = packageInfo.buildNumber;
    String version = packageInfo.version;
    var sub = await Firestore.instance
        .collection('info')
        .where('key', isEqualTo: 'buildNumber')
        .getDocuments();
    var info = sub.documents;
    print("Version is:" + version);
    if (info.isNotEmpty) {
      if (Platform.isAndroid) {
        if (int.parse(buildNumber) < info[0]['androidBuildNumber']) {
          setState(() {
            email = 'update';
          });
        } else {
          getData();
        }
      } else {
        if (int.parse(version) < info[0]['iosBuildNumber']) {
          setState(() {
            email = 'update';
          });
        } else {
          getData();
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'GoogleSans',
          primaryColor: Color(0xff0D47A1),
          accentColor: Color(0xff90CAF9),
          textSelectionColor: Colors.red),
      home: email == null
          ? PrivacyPolicy()
          : email == 'admin'
              ? AdminHome()
              : email == 'update'
                  ? UpdateScreen()
                  : Home(),
      //home: AdminHome(),
    );
  }
}
