import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mydoctor/widgets/archive-card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Challenge extends StatefulWidget {
  @override
  _ChallengeState createState() => _ChallengeState();
}

class _ChallengeState extends State<Challenge> {

  final CollectionReference collectionReference  = Firestore.instance.collection("challenge1");
  List<DocumentSnapshot> dataList;
  StreamSubscription<QuerySnapshot> subscription;



  getDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    subscription = collectionReference.where('email', isEqualTo: email).orderBy("timestamp", descending: true).snapshots().listen((datasnapshot){
      setState(() {
        dataList = datasnapshot.documents;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();

  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/mainback.png'),fit: BoxFit.fill)
        ),

        child: Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(40)),
            child: dataList!=null?
            ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context,i){
                String date = dataList[i]['date'];
                String image = dataList[i]['image']!=null?dataList[i]['image']:'';
                String medName = dataList[i]['medicine']!=null?dataList[i]['medicine']:'';
                bool completed = dataList[i]['completed'];
                String text = dataList[i]['text'];
                print(completed);

                return Padding(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(35)),
                  child: ArchiveCard(type: 'image',date: date,image: image,medicineName: medName,isQuantity: false,isComplete: completed,text: text,),
                );
              },
            ):
            Center(child: CircularProgressIndicator(),)
        ),


      ),
    );
  }
}
