import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mydoctor/screens/admin/admin-challenge-complete.dart';
import 'package:mydoctor/screens/admin/admin-exsisting-complete.dart';
import 'package:mydoctor/screens/admin/admin-newrecipe-complete.dart';
import 'package:mydoctor/widgets/custom-text.dart';


class AdminCompleted extends StatefulWidget {


  @override
  _AdminCompletedState createState() => _AdminCompletedState();
}

class _AdminCompletedState extends State<AdminCompleted> with SingleTickerProviderStateMixin{
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
        title: CustomText(text: 'Richieste completate',),
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
          AdminExsistingComplete(),
          AdminNewRecipeComplete(),
          AdminChallangeComplete(),
        ],
      ),

    );
  }
}
