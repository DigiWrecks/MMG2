import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mydoctor/screens/admin/admin-login.dart';
import 'package:mydoctor/screens/register.dart';
import 'package:mydoctor/widgets/button.dart';
import 'package:mydoctor/widgets/custom-text.dart';
import 'package:mydoctor/widgets/inputfield.dart';
import 'package:mydoctor/widgets/toast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class LogIn extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference collectionReference = Firestore.instance.collection('users');

  signInWithEmail(BuildContext context) async {
    try{
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      FirebaseUser user = result.user;
      print(user.uid);

      var sub = await Firestore.instance.collection('users').where('email',isEqualTo: email.text).getDocuments();
      var logged = sub.documents;

      SharedPreferences prefs = await SharedPreferences.getInstance();

      OneSignal.shared.getPermissionSubscriptionState().then((result) {
        var playerId = result.subscriptionStatus.userId;
        print('User id is ${result.subscriptionStatus.userId}');
        prefs.setString('notificationId', playerId);
      });

      prefs.setString('email', user.email);
      prefs.setString('tax', logged[0]['tax']);
      prefs.setString('location', logged[0]['location']);
      prefs.setString('name', logged[0]['fname'].trim()+' '+logged[0]['lname'].trim());

      List<String> searchStrings = [logged[0]['fname'].trim(),logged[0]['lname'].trim()];
      prefs.setStringList('searchString', searchStrings);

      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);
    }
    catch(E){
      print(E);
      ToastBar(color: Colors.red,text: 'Errore').show();
    }
  }

  resetPassword() async {
    if(email.text!=''){
      try{
        await _firebaseAuth.sendPasswordResetEmail(email: email.text);
        ToastBar(text: 'Link reset password inviato via mail',color: Colors.green).show();
      }
      catch(E){
        ToastBar(text: 'Errore',color: Colors.red).show();
      }

    }
    else{
      ToastBar(text: 'Inserire indirizzo email',color: Colors.red).show();
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
                CustomText(text: 'Accedere',size: ScreenUtil().setSp(60)),

                InputField(hint: 'Email',type: TextInputType.emailAddress,controller: email,),
                InputField(hint: 'Password',ispassword: true,controller: password,),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(60)),
                  child: Button(text: 'Accesso',onclick: ()=>signInWithEmail(context),),
                ),
                Center(
                  child: GestureDetector(
                      onTap: ()=>resetPassword(),
                      child: CustomText(text: "Ha dimenticato la password",size: ScreenUtil().setSp(30),align: TextAlign.center,)),
                ),
                SizedBox(height: ScreenUtil().setHeight(45),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: CustomText(text: "Non hai un account? Iscriviti",size: ScreenUtil().setSp(25),)),

                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: CustomText(text: 'Accedi come',),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminLogin()),
                        );
                      },
                    )
                  ],
                ),



              ],
            ),
          ),
        ),



      ),
    );
  }
}
//e084fe5943e6213acf0a2be751b6485d