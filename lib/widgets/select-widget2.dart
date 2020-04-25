import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mydoctor/data/element-1-data.dart';
import 'package:mydoctor/widgets/toast.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SelectWidget2 extends StatefulWidget {
  final Element1Data object;
  final String itemNo;
  final TextEditingController controller;
  final String storageLocation;

  const SelectWidget2({Key key, this.object, this.itemNo, this.controller, this.storageLocation='certified',}) : super(key: key);
  @override
  _SelectWidget2State createState() => _SelectWidget2State();
}

class _SelectWidget2State extends State<SelectWidget2> {
  Color _color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _color = Color(0xff4A148C);
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return GestureDetector(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String email = prefs.getString('email');
        File image = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 50);
        try{
          StorageReference ref = FirebaseStorage.instance.ref().child("${widget.storageLocation}/$email/${basename(image.path)}");
          ToastBar(text: 'Caricamento',color: Colors.orangeAccent).show();
          StorageUploadTask uploadTask = ref.putFile(image);
          final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
          String imgurl = (await downloadUrl.ref.getDownloadURL());
          print("url is $imgurl");
          setState(() {
            _color = Colors.green;
          });
          widget.object.setImage(imageVar: 'I${widget.itemNo}',value: imgurl);
          ToastBar(text: 'Caricato',color: Colors.green).show();
        }
        catch(e){
          print(e);
          ToastBar(text: 'Errore caricamento immagine',color: Colors.red).show();
        }
      },
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(170),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _color
        ),

        child: Icon(Icons.file_upload,color: Colors.white,size: 38,),
      ),
    );
  }
}
