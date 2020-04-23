import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mydoctor/screens/archives/challenge.dart';
import 'package:mydoctor/screens/archives/exsisting.dart';
import 'package:mydoctor/screens/archives/new-recipe.dart';
import 'package:mydoctor/widgets/custom-text.dart';


class Element5 extends StatefulWidget {


  @override
  _Element5State createState() => _Element5State();
}

class _Element5State extends State<Element5> with SingleTickerProviderStateMixin{
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
        title: CustomText(text: 'Archivio Ricette',),
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
          Exsisting(),
          NewRecipe(),
          Challenge(),
        ],
      ),

    );
  }
}
