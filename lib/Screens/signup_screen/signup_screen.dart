import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycart/Screens/home_screen/home_screen.dart';
import 'package:mycart/Screens/login_screen/login_screen.dart';
import 'package:mycart/Values/app_colors.dart';
import 'package:mycart/Values/image_assets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class signupScreen extends StatefulWidget {
  @override
  _signupScreenState createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  var username,password,confirmPassword,phone;
  ProgressDialog pd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username=TextEditingController(text: "");
    password=TextEditingController(text:"");
    confirmPassword=TextEditingController(text:"");
    phone=TextEditingController(text:"");
  }

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var mediaQuery=MediaQuery.of(context).size;
    pd=ProgressDialog(context);
    pd.style(
      message: 'Please wait...',
      elevation: 6.0,
      backgroundColor: AppColors.primaryWhite,
      borderRadius: 2.0,
    );
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: AppColors.primaryLightColor,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: width*0.9,
                height: height*0.45,
                child: SvgPicture.asset(ImageUrl.signUp,),
              ),
              Container(
                child: Center(
                  child: Text('Sign up',style: TextStyle(
                      color: AppColors.primaryDark,fontSize: 25,decoration: TextDecoration.none
                  ),),
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                  width: width*0.9,
                  child:Column(
                    children: <Widget>[
                      TextField(
                        style: TextStyle(
                            color: AppColors.primaryDark,fontSize: 15,decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold
                        ),
                        controller: username,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                              color: AppColors.primaryDark,fontSize: 15,decoration: TextDecoration.none,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      TextField(
                        style: TextStyle(
                            color: AppColors.primaryDark,fontSize: 15,decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold
                        ),
                        controller: password,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: AppColors.primaryDark,fontSize: 15,decoration: TextDecoration.none,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      TextField(
                        style: TextStyle(
                            color: AppColors.primaryDark,fontSize: 15,decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold
                        ),
                        controller: confirmPassword,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: "UserName",
                          hintStyle: TextStyle(
                              color: AppColors.primaryDark,fontSize: 15,decoration: TextDecoration.none,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      TextField(
                        style: TextStyle(
                            color: AppColors.primaryDark,fontSize: 15,decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold
                        ),
                        keyboardType: TextInputType.phone,
                        controller: phone,
                        decoration: InputDecoration(
                          hintText: "Phone",
                          hintStyle: TextStyle(
                              color: AppColors.primaryDark,fontSize: 15,decoration: TextDecoration.none,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(height: 30.0,),
              InkWell(
                onTap: (){
                  if(username.text.isEmpty || password.text.isEmpty || confirmPassword.text.isEmpty
                  || phone.text.isEmpty){
                    Alert(
                        context: context,
                        title: 'Warning',
                        desc: 'Please enter all the fields',
                        type: AlertType.warning,
                        buttons: [
                          DialogButton(
                            child: Text('Okay'),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            width: 50.0,
                          )
                        ]
                    ).show();

                  }else if(!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(username.text)){
                    Alert(
                        context: context,
                        title: 'Warning',
                        desc: 'Please enter valid email',
                        type: AlertType.warning,
                        buttons: [
                          DialogButton(
                            child: Text('Okay'),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            width: 50.0,
                          )
                        ]
                    ).show();
                  }else if(phone.text.toString().length<10){
                    Alert(
                        context: context,
                        title: 'Warning',
                        desc: 'Please enter valid phone number',
                        type: AlertType.warning,
                        buttons: [
                          DialogButton(
                            child: Text('Okay'),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            width: 50.0,
                          )
                        ]
                    ).show();
                  }
                  else{
                    pd.show();
                    FirebaseAuth.instance.createUserWithEmailAndPassword(email: username.text.toString(),
                        password: password.text.toString())
                        .then((suc) async{
                      User user=FirebaseAuth.instance.currentUser;
                      var id=user.uid;
                      print('here is the user id $id');
                      FirebaseFirestore.instance.collection("UserDetails").doc(id).set({
                        "UserName":confirmPassword.text.toString(),
                        "Email":username.text.toString(),
                        "Phone":phone.text.toString(),
                        "UserId":id,
                        "ImageUrl":"https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
                      }).then((value){
                        pd.hide();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>homeScreen(mediaQuery: mediaQuery,)));
                      }).catchError((e){
                        pd.hide();
                        Alert(
                            context: context,
                            title: 'Error',
                            desc: '$e',
                            type: AlertType.error,
                            buttons: [
                              DialogButton(
                                child: Text('Okay'),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                width: 50.0,
                              )
                            ]
                        ).show();
                      });
                    }).catchError((err){
                      pd.hide();
                      Alert(
                          context: context,
                          title: 'Error',
                          desc: '$err',
                          type: AlertType.error,
                          buttons: [
                            DialogButton(
                              child: Text('Okay'),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              width: 50.0,
                            )
                          ]
                      ).show();
                    });
                  }

                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryDarkColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  width: width*0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text('Sign up',style: TextStyle(
                          color: AppColors.primaryWhite,fontSize: 15,decoration: TextDecoration.none
                      ),),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Already have an account ',style: TextStyle(
                        color: AppColors.primaryDark,fontSize: 15,decoration: TextDecoration.none
                    ),),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>loginScreen()));
                      },
                      child: Text('Login',style: TextStyle(
                          color: AppColors.primaryDarkColor,fontSize: 15,decoration: TextDecoration.underline
                      ),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.0,),
            ],
          ),
        ),
      ),
    );
  }
}
