import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mydoctor/widgets/image-view.dart';
import 'package:mydoctor/widgets/toast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'custom-text.dart';

class AdminArchiveCard extends StatelessWidget {
  final String type;
  final String date;
  final String quantity;
  final String medicineName;
  final String image;
  final String tax;
  final bool isQuantity;
  final String name;
  final String docId;
  final bool isComplete;
  final String collection;
  final String playerId;

  const AdminArchiveCard({Key key, this.type, this.date, this.quantity, this.medicineName, this.image, this.isQuantity=true, this.name, this.tax, this.docId, this.isComplete=false, this.collection,this.playerId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return  Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(65)),
          child: Container(
            height: ScreenUtil().setHeight(500),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xff2E7D32)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: ScreenUtil().setHeight(60),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              width: ScreenUtil().setWidth(45),
                              height: ScreenUtil().setHeight(45),
                              child: Image.asset('images/user.png')),
                          SizedBox(width: ScreenUtil().setWidth(10),),
                          CustomText(text: name,size: ScreenUtil().setSp(35),)
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(ScreenUtil().setWidth(15)),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                  width: ScreenUtil().setWidth(45),
                                  height: ScreenUtil().setHeight(45),
                                  child: Image.asset('images/world.png')),
                              SizedBox(width: ScreenUtil().setWidth(10),),
                              CustomText(text: tax,size: ScreenUtil().setSp(35),color: Colors.black,),
                              SizedBox(width: ScreenUtil().setWidth(10),),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(40),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50)),
                  child: Row(
                    mainAxisAlignment: isQuantity==true?MainAxisAlignment.spaceBetween:MainAxisAlignment.center,
                    children: <Widget>[
                      type=='text'?Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).accentColor,
                          border: Border.all(color: Theme.of(context).primaryColor,width: 2)
                        ),
                        width: ScreenUtil().setWidth(300),
                        child: Padding(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                          child: CustomText(text: medicineName,align: TextAlign.center,size: ScreenUtil().setSp(40),color: Colors.black,),
                        ),
                      ):
                      Container(
                        width: ScreenUtil().setWidth(200),
                        height: ScreenUtil().setHeight(180),
                        child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, CupertinoPageRoute(builder: (context){
                                return ImageView(url: image,);}));
                            },
                            child: CachedNetworkImage(
                              imageUrl: image,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  Center(child: CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                    backgroundColor: Colors.white,
                                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),)),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            )),
                      ),
                      isQuantity==true?CircleAvatar(
                        backgroundColor: Color(0xffBDBDBD),
                        radius: 32,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 30,
                          child: CustomText(text: quantity,size: ScreenUtil().setSp(50),),
                        ),
                      ):SizedBox.shrink()
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(40),),
                isComplete==false?Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50)),
                  child: RaisedButton(
                    onPressed: (){
                      try{
                          Firestore.instance.collection(collection).document(docId).updateData({
                            'completed': true
                          });

                          OneSignal.shared.postNotification(OSCreateNotification(
                            playerIds: [playerId],
                            content: "La richiesta è pronta! La tua richiesta è pronta per essere ritirata in ambulatorio.",
                            heading: "La richiesta è pronta!",
                          ));


                          ToastBar(text: 'Completato',color: Colors.green).show();
                        }
                        catch(e){
                          ToastBar(text: 'Errore',color: Colors.red).show();
                        }
                    },
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Colors.black,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.check_circle_outline,color: Colors.white,),
                        SizedBox(width: 10,),
                        CustomText(text: "Ordine completo",)
                      ],
                    )
                  )
                ):SizedBox.shrink(),
              ],
            ),
          ),
        ),

        Center(
          child: Container(
            height: ScreenUtil().setHeight(100),
            width: ScreenUtil().setWidth(400),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              border: Border.all(color: Color(0xffBDBDBD),width: 2)
            ),

            child: Center(child: CustomText(text: date,size: ScreenUtil().setSp(40),)),
          ),
        )

      ],
    );
  }
}
