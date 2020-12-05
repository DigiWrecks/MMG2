import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mydoctor/widgets/button.dart';
import 'package:mydoctor/widgets/custom-text.dart';
import 'package:mydoctor/widgets/profile-input-field.dart';
import 'package:mydoctor/widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Profile extends StatefulWidget {


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController fiscal = TextEditingController();
  TextEditingController tax = TextEditingController();
  String email;

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    var sub =  await Firestore.instance.collection('users1').where('email',isEqualTo: email).getDocuments();
    var list = sub.documents;

    setState(() {
      fname.text = list[0]['fname'];
      lname.text = list[0]['lname'];
      phone.text = list[0]['phone'];
      tax.text = list[0]['tax'];
      fiscal.text = list[0]['fiscal'];
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
    ScreenUtil.init(context, width: 720, height: 1520,allowFontScaling: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: CustomText(text: 'Profile',),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('images/mainback.png'),fit: BoxFit.fill)
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(40),),
              ProfileInputField(hint: 'Nome',controller: fname,),
              ProfileInputField(hint: 'Cognome',controller: lname,),
              ProfileInputField(hint: 'Telefono',controller: phone,),
              ProfileInputField(hint: 'Codice Fiscale',controller: fiscal,),
              ProfileInputField(hint: 'Codice esenzione',type: TextInputType.phone,controller: tax,),
              SizedBox(height: ScreenUtil().setHeight(20),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                child: Button(text: 'Update',onclick: () async {
                  try{
                    Firestore.instance.collection('users1').document(email).updateData({
                      'fname': fname.text,
                      'lname': lname.text,
                      'phone': phone.text,
                      'tax': tax.text,
                      'fiscal': fiscal.text,
                    });
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('tax', tax.text);
                    prefs.setString('name', fname.text+' '+lname.text);
                    List<String> searchStrings = [fname.text,lname.text];
                    prefs.setStringList('searchString', searchStrings);
                    getData();
                    ToastBar(text: 'Data Updated!',color: Colors.green).show();
                  }
                  catch(e){
                    ToastBar(text: 'Something went wrong',color: Colors.red).show();
                  }
                }),
              ),
              SizedBox(height: ScreenUtil().setHeight(20),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                child: Button(text: 'Log Out',onclick: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('email', null);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => LogIn()),
                  );
                  // Navigator.of(context).pushAndRemoveUntil(
                  //     CupertinoPageRoute(builder: (context) => LogIn()), (Route<dynamic> route) => false);
                }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
