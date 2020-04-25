import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mydoctor/widgets/custom-text.dart';

class Contact extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: CustomText(text: 'Contatti',),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/mainback.png'),fit: BoxFit.fill)
        ),
        
        child: Padding(
          padding: EdgeInsets.all(ScreenUtil().setWidth(50)),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: ScreenUtil().setHeight(30),),
              Expanded(
                child: Container(
                    height: ScreenUtil().setHeight(100),
                    child: Center(child: Image.asset('images/contact.png',fit: BoxFit.contain,))),
              ),
                SizedBox(height: ScreenUtil().setHeight(30),),
              Container(
                width: double.infinity,
                color: Theme.of(context).accentColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(ScreenUtil().setHeight(30),ScreenUtil().setHeight(30),0,0),
                      child: CustomText(text: 'Ambulatorio',color: Colors.black,size: ScreenUtil().setSp(50),),
                    ),

                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                            child: CustomText(text: 'Ripatransone\nPiazza Madre Teresa di Calcutta, 1',),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(30),),
              Container(
                width: double.infinity,
                color: Theme.of(context).accentColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(ScreenUtil().setHeight(30),ScreenUtil().setHeight(30),0,0),
                      child: CustomText(text: 'Telefono',color: Colors.black,size: ScreenUtil().setSp(50),),
                    ),

                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).primaryColor
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                            child: CustomText(text: '377.3594677',),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(30),),
              Container(
                width: double.infinity,
                color: Theme.of(context).accentColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(ScreenUtil().setHeight(30),ScreenUtil().setHeight(30),0,0),
                      child: CustomText(text: 'Email',color: Colors.black,size: ScreenUtil().setSp(50),),
                    ),

                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).primaryColor
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                            child: CustomText(text: 'katia.caucci@gmail.com',),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(30),),


            ],),


          ),
        ),

      ),
    );
  }
}
