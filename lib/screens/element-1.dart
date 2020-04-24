import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mydoctor/data/element-1-data.dart';
import 'package:mydoctor/widgets/button.dart';
import 'package:mydoctor/widgets/custom-text.dart';
import 'package:mydoctor/widgets/select-widget.dart';
import 'package:mydoctor/widgets/toast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Element1 extends StatelessWidget {
  TextEditingController q1 = TextEditingController();
  TextEditingController q2 = TextEditingController();
  TextEditingController q3 = TextEditingController();
  TextEditingController q4 = TextEditingController();
  TextEditingController q5 = TextEditingController();
  TextEditingController m1 = TextEditingController();
  TextEditingController m2 = TextEditingController();
  TextEditingController m3 = TextEditingController();
  TextEditingController m4 = TextEditingController();
  TextEditingController m5 = TextEditingController();
  Element1Data data = Element1Data();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: CustomText(text: 'Ricette Terapie Croniche',),
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
                SelectWidget(quantityController: q1,medicineController: m1,itemNo: '1',object: data,),
                SizedBox(height: ScreenUtil().setHeight(50),),
                SelectWidget(medicineController: m2,quantityController: q2,itemNo: '2',object: data,),
                SizedBox(height: ScreenUtil().setHeight(50),),
                SelectWidget(medicineController: m3,quantityController: q3,itemNo: '3',object: data,),
                SizedBox(height: ScreenUtil().setHeight(50),),
                SelectWidget(medicineController: m4,quantityController: q4,itemNo: '4',object: data,),
                SizedBox(height: ScreenUtil().setHeight(50),),
                SelectWidget(medicineController: m5,quantityController: q5,itemNo: '5',object: data,),

                SizedBox(height: ScreenUtil().setHeight(80),),
                Button(text: 'Invia al dottore',onclick: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String email = prefs.getString('email');
                  String tax = prefs.getString('tax');
                  String location = prefs.getString('location');
                  String name = prefs.getString('name');
                  String notId = prefs.getString('notificationId');
                  List search = prefs.getStringList('searchString');


                  saveAsImage(String image,String quantity) async {
                    try{
                      Firestore.instance.collection('existing').add({
                        'date': DateFormat('dd/MM/yyyy').format(DateTime.now()),
                        'type': 'image',
                        'quantity': quantity,
                        'image': image,
                        'name': name,
                        'search': search,
                        'notification': notId,
                        'email': email,
                        'timestamp': DateTime.now(),
                        'tax': tax,
                        'location': location,
                        'completed': false,
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

                  saveAsText(String text,String quantity) async {
                    try{
                      Firestore.instance.collection('existing').add({
                        'date': DateFormat('dd/MM/yyyy').format(DateTime.now()),
                        'type': 'text',
                        'quantity': quantity,
                        'medicine': text,
                        'name': name,
                        'email': email,
                        'search': search,
                        'completed': false,
                        'notification': notId,
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


                      Navigator.push(context, CupertinoPageRoute(builder: (context){
                        return Home();}));

                      ToastBar(text: 'Richiesta inviata',color: Colors.green).show();
                    }
                    catch(e){
                      ToastBar(text: e.toString(),color: Colors.red).show();
                    }
                  }

                  ////part 1
                  if(data.select1=='image'){
                    if(data.image1!=''&&q1.text!=''){
                      print('data added on 1 in ${data.image1}');
                     await saveAsImage(data.image1, q1.text);
                    }
                    else if(data.image1!=''&&q1.text==''){
                      ToastBar(text: 'Inserisci tutte le informazioni',color: Colors.red).show();
                    }
                  }else{
                    if(m1.text!=''&&q1.text!=''){
                      print('data added on 1 in ${data.image1}');
                      await saveAsText(m1.text, q1.text);
                    }
                    else if(m1.text!=''&&q1.text==''){
                      ToastBar(text: 'Inserisci tutte le informazioni',color: Colors.red).show();
                    }
                  }


                ////part 2
                  if(data.select2=='image'){
                    if(data.image2!=''&&q2.text!=''){
                      print('data added on 2 in ${data.image2}');
                      await saveAsImage(data.image2, q2.text);
                    }
                    else if(data.image2!=''&&q2.text==''){
                      ToastBar(text: 'Inserisci tutte le informazioni',color: Colors.red).show();
                    }
                  }else{
                    if(m2.text!=''&&q2.text!=''){
                      print('data added on 2 in ${data.image2}');
                      await saveAsText(m2.text, q2.text);
                    }
                    else if(m2.text!=''&&q2.text==''){
                      ToastBar(text: 'Inserisci tutte le informazioni',color: Colors.red).show();
                    }
                  }


                  ////part 3
                  if(data.select3=='image'){
                    if(data.image3!=''&&q3.text!=''){
                      print('data added on 3 in ${data.image3}');
                      await saveAsImage(data.image3, q3.text);
                    }
                    else if(data.image3!=''&&q3.text==''){
                      ToastBar(text: 'Inserisci tutte le informazioni',color: Colors.red).show();
                    }
                  }else{
                    if(m3.text!=''&&q3.text!=''){
                      print('data added on 3 in ${data.image3}');
                      await saveAsText(m3.text, q3.text);
                    }
                    else if(m3.text!=''&&q3.text==''){
                      ToastBar(text: 'Inserisci tutte le informazioni',color: Colors.red).show();
                    }
                  }


                  ////part 4
                  if(data.select4=='image'){
                    if(data.image4!=''&&q4.text!=''){
                      print('data added on 4 in ${data.image4}');
                      await saveAsImage(data.image4, q4.text);
                    }
                    else if(data.image4!=''&&q4.text==''){
                      ToastBar(text: 'Inserisci tutte le informazioni',color: Colors.red).show();
                    }
                  }else{
                    if(m4.text!=''&&q4.text!=''){
                      print('data added on 4 in ${data.image4}');
                      await saveAsText(m4.text, q4.text);
                    }
                    else if(m4.text!=''&&q4.text==''){
                      ToastBar(text: 'Inserisci tutte le informazioni',color: Colors.red).show();
                    }
                  }

                  ////part 5
                  if(data.select5=='image'){
                    if(data.image5!=''&&q5.text!=''){
                      print('data added on 5 in ${data.image5}');
                      await saveAsImage(data.image5, q5.text);
                    }
                    else if(data.image5!=''&&q5.text==''){
                      ToastBar(text: 'Inserisci tutte le informazioni',color: Colors.red).show();
                    }
                  }else{
                    if(m5.text!=''&&q5.text!=''){
                      print('data added on 5 in ${data.image5}');
                      await saveAsText(m5.text, q5.text);
                    }
                    else if(m5.text!=''&&q5.text==''){
                      ToastBar(text: 'Inserisci tutte le informazioni',color: Colors.red).show();
                    }
                  }

                },)
              ],
            ),
          ),
        ),


      ),
    );
  }
}
