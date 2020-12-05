import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mydoctor/widgets/button.dart';
import 'package:mydoctor/widgets/custom-text.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(text: "Se avete la vecchia versione dell'app procedere con l' aggiornamento alla nuova versione per un'esperienza migliore e nuove caratteristiche.",size: 20,color: Colors.black,align: TextAlign.center,),
            Padding(
              padding: EdgeInsets.all(25),
              child: Button(text: 'Aggiornamento',color: Colors.green,onclick: () async {
                String url;
                if(Platform.isAndroid){
                  url = 'https://play.google.com/store/apps/details?id=com.digiwrecks.mydoctor';
                }
                else{
                  url = 'https://apps.apple.com/us/app/mmg2-dott-ssa-katia-caucci/id1536182060';
                }
                if (await canLaunch(url)) {
                await launch(url);
                } else {
                throw 'Could not launch $url';
                }
              },),
            ),
          ],
        ),
      ),
    );
  }
}
