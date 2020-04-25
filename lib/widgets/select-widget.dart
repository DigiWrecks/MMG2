import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mydoctor/data/element-1-data.dart';
import 'package:mydoctor/widgets/custom-text.dart';
import 'package:mydoctor/widgets/toast.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectWidget extends StatefulWidget {
  final TextEditingController quantityController;
  final TextEditingController medicineController;
  final String itemNo;
  final Element1Data object;

  const SelectWidget({Key key, this.quantityController, this.medicineController, this.itemNo, this.object}) : super(key: key);
  @override
  _SelectWidgetState createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  double _height = 170;
  String item1;
  Widget bottomWidget;
  Color _color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    item1 = 'image';
    _color = Color(0xff9C27B0);
    bottomWidget =GestureDetector(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String email = prefs.getString('email');
          File image = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 50);
          try{
            StorageReference ref = FirebaseStorage.instance.ref().child("exsiting/$email/${basename(image.path)}");
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
              borderRadius: BorderRadius.circular(10),
              color: Colors.black
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10,5,10,5),
            child: Icon(Icons.camera_alt,color: Colors.white,size: 30,),
          ),
        )
    );

  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return Stack(
      children: <Widget>[
        Center(
          child: AnimatedPadding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(_height)),
            duration: Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            child: Container(
              width: ScreenUtil().setWidth(500),
              height: ScreenUtil().setHeight(150),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                  color: Theme.of(context).accentColor
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  bottomWidget,

                  SizedBox(width: ScreenUtil().setWidth(30),),
                  Container(
                    height: ScreenUtil().setHeight(80),
                    width: ScreenUtil().setWidth(180),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.top,
                          controller: widget.quantityController,
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(35)),
                          decoration: new InputDecoration.collapsed(
                              hintText: 'Quantità',
                              hintStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(35))
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),

            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: ScreenUtil().setHeight(170),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: _color
          ),

          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                child: DropdownButton(
                  underline: Divider(color: Colors.white,height: 0,thickness: 0,),
                  items: [
                    DropdownMenuItem(child: CustomText(text: 'Immagine',color: Colors.black,),value: 'image',),
                    DropdownMenuItem(child: CustomText(text: 'Testo',color: Colors.black,),value: 'text',),
                  ],onChanged:(newValue){
                  setState(() {
                    _height = 0;
                    widget.object.setSelected(select: 'S${widget.itemNo}',value: newValue);
                    Timer(Duration(milliseconds: 300), (){
                      setState(() {
                        if(newValue == 'image'){
                          bottomWidget =GestureDetector(
                              onTap: () async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                String email = prefs.getString('email');
                                File image = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 50);
                                try{
                                  StorageReference ref = FirebaseStorage.instance.ref().child("exsiting/$email/${basename(image.path)}");
                                  ToastBar(text: 'Caricamento',color: Colors.orangeAccent).show();
                                  StorageUploadTask uploadTask = ref.putFile(image);
                                  final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
                                  String imgurl = (await downloadUrl.ref.getDownloadURL());
                                  print("url is $imgurl");
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
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10,5,10,5),
                                  child: Icon(Icons.camera_alt,color: Colors.white,size: 30,),
                                ),
                              )
                          );
                        }
                        else{
                          bottomWidget =  Container(
                            height: ScreenUtil().setHeight(80),
                            width: ScreenUtil().setWidth(250),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                                child: TextField(
                                  controller: widget.medicineController,
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.top,
                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(30)),
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Medicina',
                                      hintStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(30))
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        _height = 170;
                      });
                    });
                    item1 = newValue;

                  });
                },
                  value: item1,
                ),
              ),
            ),
          ),

        ),
      ],
    );
  }
}
