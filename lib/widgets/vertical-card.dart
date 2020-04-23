import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mydoctor/widgets/custom-text.dart';

class VerticalCard extends StatelessWidget {

  final String text;
  final String image;
  final Color color;
  final Widget navigationTo;
  const VerticalCard({Key key, this.text, this.image, this.color, this.navigationTo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => navigationTo),
        );
      },
      child: Container(
        width: ScreenUtil().setWidth(300),
        height: ScreenUtil().setHeight(440),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).accentColor
        ),

        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                height: ScreenUtil().setHeight(350),
                child: Padding(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                  child: Image.asset(image,fit: BoxFit.contain,),
                ),

              ),
            ),

            Expanded(
              flex: 4,
              child: Container(
                width: ScreenUtil().setWidth(300),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                    color: color
                ),
                child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
                      child: CustomText(text: text,size: ScreenUtil().setSp(38,allowFontScalingSelf: true),align: TextAlign.center,),
                    )),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
