import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mydoctor/widgets/custom-text.dart';

class HorizontalCard extends StatelessWidget {

  final String text;
  final String image;
  final Color color;
  final Widget navigationTo;

  const HorizontalCard({Key key, this.text, this.image, this.color, this.navigationTo}) : super(key: key);

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
        width: MediaQuery.of(context).size.width,
        height: ScreenUtil().setHeight(300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).accentColor
        ),

        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: ScreenUtil().setHeight(300),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
                    color: color
                ),
                child: Center(
                    child: CustomText(text: text,size: ScreenUtil().setSp(50,allowFontScalingSelf: true),align: TextAlign.center,)),
              ),
            ),

            Expanded(
              child: Container(
                height: ScreenUtil().setHeight(300),
                child: Padding(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                  child: Image.asset(image,fit: BoxFit.contain,),
                ),

              ),
            ),

          ],
        ),
      ),
    );
  }
}
