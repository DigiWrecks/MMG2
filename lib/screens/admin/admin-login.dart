import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mydoctor/screens/admin/admin-home.dart';
import 'package:mydoctor/widgets/button.dart';
import 'package:mydoctor/widgets/custom-text.dart';
import 'package:mydoctor/widgets/inputfield.dart';
import 'package:mydoctor/widgets/toast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AdminLogin extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signInAdmin(BuildContext context) async {
    var sub = await Firestore.instance.collection('admin').where('email', isEqualTo: email.text).getDocuments();
    var user = sub.documents;

    if (user.isNotEmpty) {
      String docId = user[0].documentID;

      if (user[0].data['password'] == password.text) {
        print('admin logged in');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', 'admin');


        OneSignal.shared.getPermissionSubscriptionState().then((result) {
          var playerId = result.subscriptionStatus.userId;

          List deviceIds = user[0].data['notification'];
          if(!deviceIds.contains(playerId)){
            deviceIds.add(playerId);
            print(deviceIds);
            Firestore.instance.collection('admin').document(docId).updateData({
              'notification': deviceIds
            });
          }


        });

        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (context) => AdminHome()), (Route<dynamic> route) => false);
        
      } else {
        ToastBar(text: 'Email o password non corretti', color: Colors.red)
            .show();
      }
    } else {
      ToastBar(text: 'Admin non esistente', color: Colors.red).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/loginback.png'),fit: BoxFit.fill)
        ),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: ScreenUtil().setHeight(750),),
                CustomText(text: 'Accedi\ncome amministratore',size: ScreenUtil().setSp(60)),

                InputField(hint: 'Email',type: TextInputType.emailAddress,controller: email,),
                InputField(hint: 'Password',ispassword: true,controller: password,),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(70)),
                  child: Button(text: 'Accesso',onclick: ()=>signInAdmin(context),),
                ),

              ],
            ),
          ),
        ),



      ),
    );
  }
}
