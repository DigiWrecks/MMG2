import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mydoctor/widgets/button.dart';
import 'package:mydoctor/widgets/custom-text.dart';
import 'package:mydoctor/widgets/inputfield.dart';
import 'package:mydoctor/widgets/toast.dart';

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController tax = TextEditingController();
  TextEditingController fiscal = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String location;

  CollectionReference collectionReference = Firestore.instance.collection('users');

  signUp() async {
    if(email.text!='' && password.text!='' && fname.text!=''&& lname.text!=''&& phone.text!=''&& fiscal.text!=''){
      try{
        AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        FirebaseUser user = result.user;
        print(user.uid);

        await collectionReference.document(email.text).setData({
          'fname': fname.text[0].toUpperCase()+fname.text.substring(1),
          'lname': lname.text[0].toUpperCase()+lname.text.substring(1),
          'phone': phone.text,
          'email': email.text,
          'fiscal': fiscal.text,
          'tax': tax.text,
          'location': location
        });

        fname.clear();
        lname.clear();
        email.clear();
        tax.clear();
        phone.clear();
        fiscal.clear();
        password.clear();
        ToastBar(color: Colors.green,text: 'Registrazione avvenuta!').show();
      }
      catch(E){
        ToastBar(color: Colors.red,text: 'Errore!').show();
        print(E);
      }
    }else{
      ToastBar(color: Colors.red,text: 'Inserire campi obbligatori').show();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location = 'Ripatransone';
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1520, allowFontScaling: false);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/registerback.png'),fit: BoxFit.fill)
        ),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: ScreenUtil().setHeight(400),),
                CustomText(text: 'Registrazione',size: ScreenUtil().setSp(60)),

                InputField(hint: 'Nome *',controller: fname,),
                InputField(hint: 'Cognome *',controller: lname,),
                InputField(hint: 'Telefono *',controller: phone,type: TextInputType.phone,),
                InputField(hint: 'Email *',type: TextInputType.emailAddress,controller: email,),
                InputField(hint: 'Password *',ispassword: true,controller: password,),
                InputField(hint: 'Codice Fiscale *',controller: fiscal,),
                InputField(hint: 'Codice esenzione',controller: tax,),

                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
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
                            DropdownMenuItem(child: CustomText(text: 'Ripatransone',color: Colors.black,),value: 'Ripatransone',),
                            DropdownMenuItem(child: CustomText(text: 'Cossignano',color: Colors.black,),value: 'Cossignano',),
                          ],onChanged:(newValue){
                         setState(() {
                           location = newValue;
                         });
                        },
                          value: location,
                        ),
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(60)),
                  child: Button(text: 'Registrati',onclick: ()=>signUp(),),
                )

              ],
            ),
          ),
        ),



      ),
    );
  }
}
