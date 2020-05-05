import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mydoctor/screens/contact.dart';
import 'package:mydoctor/screens/element-2.dart';
import 'package:mydoctor/screens/element-4.dart';
import 'package:mydoctor/screens/element-5.dart';
import 'package:mydoctor/screens/profile.dart';
import 'package:mydoctor/widgets/button.dart';
import 'package:mydoctor/widgets/custom-text.dart';
import 'package:mydoctor/widgets/vertical-card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'element-1.dart';

class Home extends StatelessWidget {

  _launchURL() async {
    const url = 'http://www.farmaciediturno.net/farmacie-aperte-a-Ascoli%20Piceno%20(AP).html';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
            child: IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String email = prefs.getString('email');
                Navigator.push(context, CupertinoPageRoute(builder: (context){
                    return Profile();}));

              },
            ),
          )
        ],
        title: CustomText(text: 'Menu',),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/mainback.png'),fit: BoxFit.fill)
        ),

        child: Padding(
          padding: EdgeInsets.all(ScreenUtil().setWidth(40)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: ScreenUtil().setHeight(30),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    VerticalCard(text: 'Ricette Terapie Croniche',color: Color(0xff9C27B0),image: 'images/home1.png',navigationTo: Element1(),),
                    VerticalCard(text: 'Richieste farmaco da specialista',color: Color(0xffD81B60),image: 'images/home2.png',navigationTo: Element2(),),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(40),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    VerticalCard(text: 'Impegnative accertamenti da specialista',color: Color(0xff4A148C),image: 'images/home2.png',navigationTo: Element4(),),
                    VerticalCard(text: 'Archivio Ricette',color: Color(0xff2E7D32),image: 'images/home3.png',navigationTo: Element5(),),
                  ],
                ),

                SizedBox(height: ScreenUtil().setHeight(60),),
                Button(text: 'Contatti',onclick: (){
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => Contact()),
                  );
                },),
                SizedBox(height: ScreenUtil().setHeight(40),),
                Button(text: 'farmacie di turno',onclick: ()=>_launchURL(),)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
