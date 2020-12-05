import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mydoctor/data/element-1-data.dart';
import 'package:mydoctor/widgets/button.dart';
import 'package:mydoctor/widgets/custom-text.dart';
import 'package:mydoctor/widgets/select-widget2.dart';
import 'package:mydoctor/widgets/toast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Element4 extends StatelessWidget {
  Element1Data data = Element1Data();
  TextEditingController m1 = TextEditingController();
  TextEditingController m2 = TextEditingController();
  TextEditingController m3 = TextEditingController();
  TextEditingController m4 = TextEditingController();
  TextEditingController m5 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: CustomText(text: 'Impegnative accertamenti da specialista',),
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
                SelectWidget2(object: data,itemNo: '1',controller: m1,storageLocation: 'challenge',),
                SizedBox(height: ScreenUtil().setHeight(40),),
                SelectWidget2(object: data,itemNo: '2',controller: m2,storageLocation: 'challenge',),
                SizedBox(height: ScreenUtil().setHeight(40),),
                SelectWidget2(object: data,itemNo: '3',controller: m3,storageLocation: 'challenge',),
                SizedBox(height: ScreenUtil().setHeight(40),),
                SelectWidget2(object: data,itemNo: '4',controller: m4,storageLocation: 'challenge',),
                SizedBox(height: ScreenUtil().setHeight(40),),
                SelectWidget2(object: data,itemNo: '5',controller: m5,storageLocation: 'challenge',),



                SizedBox(height: ScreenUtil().setHeight(80),),
                Button(text: 'Invia al dottore',onclick: () async {
                  ToastBar(text: 'Attendere prego',color: Colors.orange).show();
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String email = prefs.getString('email');
                  String tax = prefs.getString('tax');
                  String location = prefs.getString('location');
                  String name = prefs.getString('name');
                  String notId = prefs.getString('notificationId');
                  List search = prefs.getStringList('searchString');

                  saveAsImage(String image) async {
                    try{
                      Firestore.instance.collection('challenge1').add({
                        'date': DateFormat('dd/MM/yyyy').format(DateTime.now()),
                        'type': 'image',
                        'image': image,
                        'name': name,
                        'search': search,
                        'notification': notId,
                        'completed': false,
                        'email': email,
                        'timestamp': DateTime.now(),
                        'tax': tax,
                        'location': location,
                      });

                      var sub = await Firestore.instance.collection('admin').where('email', isEqualTo: 'katia.caucci@gmail.com').getDocuments();
                      var user = sub.documents;
                      List playerId = user[0]['notification'];
                      List<String> playerIds = List<String>.from(playerId);

                      OneSignal.shared.postNotification(OSCreateNotification(
                        playerIds: playerIds,
                        content: "Ricevuta nuova richiesta. Vai all'app MGG2",
                        heading: "Ricevuta nuova richiesta!",
                      ));


                      ToastBar(text: 'Richiesta inviata',color: Colors.green).show();

                      Navigator.push(context, CupertinoPageRoute(builder: (context){
                        return Home();}));
                    }
                    catch(e){
                      ToastBar(text: 'Errore',color: Colors.red).show();
                    }
                  }

                  ////part 1
                  if(data.image1!=''){
                      saveAsImage(data.image1);
                    }



                  ////part 2
                  if(data.image2!=''){
                      saveAsImage(data.image2);
                    }


                  ////part 3
                  if(data.image3!=''){
                      saveAsImage(data.image3);
                    }



                  ////part 4
                  if(data.image4!=''){
                      saveAsImage(data.image4);
                    }


                  ////part 5
                  if(data.image5!=''){
                      saveAsImage(data.image5);
                    }




                },),
              ],
            ),
          ),
        ),


      ),
    );
  }
}
