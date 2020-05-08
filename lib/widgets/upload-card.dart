import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mydoctor/data/element-1-data.dart';
import 'package:mydoctor/widgets/toast.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadCard extends StatefulWidget {
  final String itemNo;
  final Element1Data object;

  const UploadCard({Key key, this.itemNo, this.object}) : super(key: key);

  @override
  _UploadCardState createState() => _UploadCardState();
}

class _UploadCardState extends State<UploadCard> {
  Color _color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _color = Color(0xffD81B60);
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return Container(
      height: ScreenUtil().setHeight(170),
      width: double.infinity,
      decoration: BoxDecoration(
        color: _color,
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

        ],
      ),

    );
  }
}
