import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mydoctor/screens/admin/admin-challenge.dart';
import 'package:mydoctor/screens/admin/admin-completed.dart';
import 'package:mydoctor/screens/admin/admin-exsisting.dart';
import 'package:mydoctor/screens/admin/admin-newrecipe.dart';
import 'package:mydoctor/widgets/custom-text.dart';


class AdminHome extends StatefulWidget {


  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> with SingleTickerProviderStateMixin{
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: CustomText(text: 'Richieste',),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context){
                  return AdminCompleted();}));
              },
              child: SizedBox(
                  width: ScreenUtil().setWidth(45),
                  height: ScreenUtil().setHeight(45),
                  child: Image.asset('images/tick.png')),
            ),
          )
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: tabController,
          tabs: <Widget>[
            Tab(child: CustomText(text: 'Ricette Terapie Croniche',align: TextAlign.center,size: ScreenUtil().setSp(24),)),
            Tab(child: CustomText(text: 'Ricette Nuove prescrizioni',align: TextAlign.center,size: ScreenUtil().setSp(24),)),
            Tab(child: CustomText(text: 'Impegnative accertamenti da specialista',align: TextAlign.center,size: ScreenUtil().setSp(24),)),
          ],
        ),
      ),

      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          AdminExsisting(),
          AdminNewRecipe(),
          AdminChallange(),
        ],
      ),

    );
  }
}
