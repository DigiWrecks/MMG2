import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mydoctor/data/element-2-data.dart';
import 'package:mydoctor/widgets/toast.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadCard extends StatelessWidget {
  final TextEditingController controller;
  final String itemNo;
  final Element2Data object;

  const UploadCard({Key key, this.controller, this.itemNo, this.object}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return Container(
      height: ScreenUtil().setHeight(170),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffD81B60),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)
        )
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String email = prefs.getString('email');
              File image = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 50);
              try{
                StorageReference ref = FirebaseStorage.instance.ref().child("new/$email/${basename(image.path)}");
                ToastBar(text: 'Caricamento',color: Colors.orangeAccent).show();
                StorageUploadTask uploadTask = ref.putFile(image);
                final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
                String imgurl = (await downloadUrl.ref.getDownloadURL());
              print("url is $imgurl");
              object.setImage(imageVar: 'I$itemNo',value: imgurl);
              ToastBar(text: 'Caricato',color: Colors.green).show();
              }
              catch(e){
              print(e);
              ToastBar(text: 'Errore caricamento immagine',color: Colors.red).show();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                child: Icon(Icons.file_upload,size: 30,),
              ),
            ),
          ),

          SizedBox(width: ScreenUtil().setWidth(40),),
          Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(400),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.top,
                  controller: controller,
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(40)),
                  decoration: new InputDecoration.collapsed(
                      hintText: 'Inserisci Quantità',
                      hintStyle:TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(40))
                  ),
                ),
              ),
            ),
          )
        ],
      ),

    );
  }
}
