import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mydoctor/data/element-2-data.dart';
import 'package:mydoctor/widgets/button.dart';
import 'package:mydoctor/widgets/custom-text.dart';
import 'package:mydoctor/widgets/toast.dart';
import 'package:mydoctor/widgets/upload-card.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Element2 extends StatelessWidget {
  Element2Data data = Element2Data();
  TextEditingController q1 = TextEditingController();
  TextEditingController q2 = TextEditingController();
  TextEditingController q3 = TextEditingController();
  TextEditingController q4 = TextEditingController();
  TextEditingController q5 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: CustomText(text: 'Ricette Nuove prescrizioni',),
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
                UploadCard(itemNo: '1',object: data,controller: q1,),
                SizedBox(height: ScreenUtil().setHeight(40),),
                UploadCard(itemNo: '2',object: data,controller: q2,),
                SizedBox(height: ScreenUtil().setHeight(40),),
                UploadCard(itemNo: '3',object: data,controller: q3,),
                SizedBox(height: ScreenUtil().setHeight(40),),
                UploadCard(itemNo: '4',object: data,controller: q4,),
                SizedBox(height: ScreenUtil().setHeight(40),),
                UploadCard(itemNo: '5',object: data,controller: q5,),

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

                  saveAsImage(String image,String quantity) async {
                    try{
                      Firestore.instance.collection('newrecipe').add({
                        'date': DateFormat('dd/MM/yyyy').format(DateTime.now()),
                        'quantity': quantity,
                        'image': image,
                        'notification': notId,
                        'name': name,
                        'search': search,
                        'completed': false,
                        'timestamp': DateTime.now(),
                        'email': email,
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


                  if(data.image1!=''&&q1.text!=''){
                    saveAsImage(data.image1, q1.text);
                  } else if(data.image1!=''&&q1.text==''){
                    ToastBar(text: 'Inserisci tutte le informazioni',color: Colors.red).show();
                  }
                  if(data.image2!=''&&q2.text!=''){
                    saveAsImage(data.image2, q2.text);
                  } else if(data.image2!=''&&q2.text==''){
                    ToastBar(text: 'Inserisci tutte le informazioni',color: Colors.red).show();
                  }
                  if(data.image3!=''&&q3.text!=''){
                    saveAsImage(data.image3, q3.text);
                  } else if(data.image3!=''&&q3.text==''){
                    ToastBar(text: 'Inserisci tutte le informazioni',color: Colors.red).show();
                  }
                  if(data.image4!=''&&q4.text!=''){
                    saveAsImage(data.image4, q4.text);
                  } else if(data.image4!=''&&q4.text==''){
                    ToastBar(text: 'Inserisci tutte le informazioni',color: Colors.red).show();
                  }
                  if(data.image5!=''&&q5.text!=''){
                    saveAsImage(data.image5, q5.text);
                  } else if(data.image5!=''&&q5.text==''){
                    ToastBar(text: 'Inserisci tutte le informazioni',color: Colors.red).show();
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
