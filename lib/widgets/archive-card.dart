import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mydoctor/widgets/image-view.dart';

import 'custom-text.dart';

class ArchiveCard extends StatelessWidget {
  final String type;
  final String date;
  final String quantity;
  final String medicineName;
  final String image;
  final bool isQuantity;
  final bool isComplete;
  final String text;
  const ArchiveCard({Key key, this.type, this.date, this.quantity, this.medicineName, this.image, this.isQuantity=true, this.isComplete, this.text=''}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return  Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(65)),
          child: Container(
            height: ScreenUtil().setHeight(360),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: isComplete==false?Color(0xffD81B60):Color(0xff2E7D32)
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: ScreenUtil().setHeight(40),),
                  Row(
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
                            ),
                        ),
                      ),
                      isQuantity==true?CircleAvatar(
                        backgroundColor: Color(0xffBDBDBD),
                        radius: 32,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 30,
                          child: CustomText(text: quantity,size: ScreenUtil().setSp(50),),
                        ),
                      ):SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20),),
                  isComplete==true?Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).accentColor,
                        border: Border.all(color: Theme.of(context).primaryColor,width: 2)
                    ),
                    width: ScreenUtil().setWidth(400),
                    child: Padding(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                      child: SelectableText(text==null?"":text,style: TextStyle(fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                      //child: CustomText(text: text,align: TextAlign.center,size: ScreenUtil().setSp(40),color: Colors.black,),
                    ),
                  ):SizedBox.shrink()
                ],
              ),
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
