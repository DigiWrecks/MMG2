import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mydoctor/screens/admin/admin-challenge.dart';
import 'package:mydoctor/screens/admin/admin-completed.dart';
import 'package:mydoctor/screens/admin/admin-exsisting.dart';
import 'package:mydoctor/screens/admin/admin-newrecipe.dart';
import 'package:mydoctor/widgets/custom-text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';

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
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('email', null);
              Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(builder: (context) => LogIn()), (Route<dynamic> route) => false);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
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
          ),

        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: tabController,
          tabs: <Widget>[
            Tab(child: CustomText(text: 'Ricette Terapie Croniche',align: TextAlign.center,size: ScreenUtil().setSp(18),)),
            Tab(child: CustomText(text: 'Richiesta farmaco da specialista',align: TextAlign.center,size: ScreenUtil().setSp(16),)),
            Tab(child: CustomText(text: 'Impegnative accertamenti da specialista',align: TextAlign.center,size: ScreenUtil().setSp(16),)),
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
