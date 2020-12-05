import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mydoctor/widgets/admin-archive-card.dart';
import 'package:mydoctor/widgets/custom-text.dart';

class AdminNewRecipe extends StatefulWidget {
  @override
  _AdminNewRecipeState createState() => _AdminNewRecipeState();
}

class _AdminNewRecipeState extends State<AdminNewRecipe> {

  final CollectionReference collectionReference  = Firestore.instance.collection("newrecipe1");
  List<DocumentSnapshot> dataList;
  var subscription;
  String email;
  String location;
  TextEditingController search = TextEditingController();
  DateTime date;
  String dateString;


  getDetails(Query col) async {

    subscription = col.snapshots().listen((datasnapshot){
      setState(() {
        dataList = datasnapshot.documents;
      });
    });


//      subscription = await col.getDocuments();
//      setState(() {
//        dataList = subscription.documents;
//      });
  }

  filterData(){
    setState(() {
      if(search.text==''&&location=='all'&&dateString==null){
        //nothing filter
        getDetails(collectionReference.orderBy("timestamp", descending: true).where('completed', isEqualTo: false));
        print('nothing');
      }
      else if(search.text==''&&location=='all'&&dateString!=null){
        //date only
        getDetails(collectionReference.where('completed', isEqualTo: false).where('date', isEqualTo: dateString));
        print('date');
      }
      else if(search.text==''&&location!='all'&&dateString==null){
        //location
        getDetails(collectionReference.orderBy("timestamp", descending: true).where('completed', isEqualTo: false).where('location',isEqualTo: location));
        print('location');
      }
      else if(search.text==''&&location!='all'&&dateString!=null){
        //location and date
        getDetails(collectionReference.where('completed', isEqualTo: false).where('location',isEqualTo: location).where('date', isEqualTo: dateString));
        print('location and date');
      }
      else if(search.text!=''&&location=='all'&&dateString==null){
        //search
        getDetails(collectionReference.orderBy("timestamp", descending: true).where('completed', isEqualTo: false).where('search',arrayContains: search.text[0].toUpperCase()+search.text.substring(1)));
        print('search');
      }
      else if(search.text!=''&&location=='all'&&dateString!=null){
        //search and date
        getDetails(collectionReference.where('completed', isEqualTo: false).where('search',arrayContains: search.text[0].toUpperCase()+search.text.substring(1)).where('date', isEqualTo: dateString));
        print('search and date');
      }
      else if(search.text!=''&&location!='all'&&dateString==null){
        //search and location
        getDetails(collectionReference.orderBy("timestamp", descending: true).where('completed', isEqualTo: false).where('search',arrayContains: search.text[0].toUpperCase()+search.text.substring(1)).where('location',isEqualTo: location));
        print('search and location');
      }
      else if(search.text!=''&&location!='all'&&dateString!=null){
        //all
        getDetails(collectionReference.where('completed', isEqualTo: false).where('search',arrayContains: search.text[0].toUpperCase()+search.text.substring(1)).where('location',isEqualTo: location).where('date', isEqualTo: dateString));
        print('all');
      }
    });


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails(collectionReference.orderBy("timestamp", descending: true).where('completed', isEqualTo: false));
    location = 'all';
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
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(500),
                          height: ScreenUtil().setHeight(70),
                          child: TextField(
                            style: TextStyle(height: 1.4),
                            controller: search,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.search),
                                filled: true,
                                contentPadding: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
                                hintStyle: TextStyle(height: 1.4),
                                hintText: 'User Name',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                            ),
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(20),),
                        Row(
                          children: <Widget>[
                            Container(
                              height: ScreenUtil().setHeight(70),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                                child: DropdownButton(
                                  underline: Divider(color: Colors.white,height: 0,thickness: 0,),
                                  items: [
                                    DropdownMenuItem(child: CustomText(text: 'All',color: Colors.black,),value: 'all',),
                                    DropdownMenuItem(child: CustomText(text: 'Ripatransone',color: Colors.black,),value: 'Ripatransone',),
                                    DropdownMenuItem(child: CustomText(text: 'Cossignano',color: Colors.black,),value: 'Cossignano',),
                                  ],onChanged:(newValue){
                                  setState(() {
                                    location = newValue;
//                                  if(location=='all'){
//                                    getDetails(collectionReference.orderBy("timestamp", descending: true).where('completed', isEqualTo: false));
//                                  }
//                                  else if(location=='Ripatransone'){
//                                    getDetails(collectionReference.orderBy("timestamp", descending: true).where('location',isEqualTo: 'Ripatransone').where('completed', isEqualTo: false));
//                                  }
                                  });
                                },
                                  value: location,
                                ),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setHeight(40),),
                            GestureDetector(
                              onTap: () async {
                                DateTime newDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020,01,01),
                                  lastDate: DateTime(2040),
                                );
                                setState(() {
                                  date = newDate;
                                  dateString = DateFormat('dd/MM/yyyy').format(date);
                                  print(dateString);
                                });
                              },
                              child: Container(
                                height: ScreenUtil().setHeight(70),
                                width: ScreenUtil().setWidth(70),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                ),
                                child: Icon(Icons.calendar_today),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: ScreenUtil().setWidth(20),),
                    Expanded(
                      child: GestureDetector(
                        onTap: ()=>filterData(),
                        child: Container(
                          height: ScreenUtil().setHeight(120),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.filter_list,color: Colors.white,),
                              CustomText(text: 'Filter',)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(40),),
                Expanded(
                  child: dataList!=null?
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: dataList.length,
                    itemBuilder: (context,i){
                      String date = dataList[i]['date'];
                      String quantity = dataList[i]['quantity'];
                      String tax = dataList[i]['tax']!=null?dataList[i]['tax']:'';
                      String name = dataList[i]['name'];
                      String image = dataList[i]['image']!=null?dataList[i]['image']:'';
                      String medName = dataList[i]['medicine']!=null?dataList[i]['medicine']:'';
                      String playerId = dataList[i]['notification'];
                      String text = dataList[i]['text'];
                      return Padding(
                        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(35)),
                        child: AdminArchiveCard(
                          type: 'image',
                          isQuantity: false,
                          date: date,
                          collection: 'newrecipe',
                          image: image,
                          playerId: playerId,
                          medicineName: medName,
                          name: name,
                          tax: tax,
                          docId: dataList[i].documentID,
                          text: text,
                        ),
                      );
                    },
                  ):
                  Center(child: CircularProgressIndicator(),),
                ),
              ],
            )
        ),


      ),
    );
  }
}
