import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycart/Screens/home_screen/home_screen.dart';
import 'package:mycart/Screens/signup_screen/signup_screen.dart';
import 'package:mycart/Values/app_colors.dart';
import 'package:mycart/Values/image_assets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  var username,password;
  ProgressDialog pd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username=TextEditingController(text: "");
    password=TextEditingController(text:"");
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
                width: width,
                height: height*0.5,
                child: SvgPicture.asset(ImageUrl.loginSvg,),
              ),
              Container(
                child: Center(
                  child: Text('Login',style: TextStyle(
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
                      decoration: InputDecoration(
                        hintText: "Username/Email",
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
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "password",
                        hintStyle: TextStyle(
                            color: AppColors.primaryDark,fontSize: 15,decoration: TextDecoration.none,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                  ],
                )
              ),
              Container(
                width: width*0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('Forgot password?',style: TextStyle(
                        color: AppColors.primaryDarkColor,fontSize: 12,decoration: TextDecoration.none
                    ),),
                  ],
                ),
              ),
              SizedBox(height: 30.0,),
              InkWell(
                onTap: (){
                  if(username.text.isEmpty || password.text.isEmpty){
                    Alert(
                        context: context,
                        title: 'Warning',
                        desc: 'Please enter all the fields',
                        type: AlertType.warning,
                        buttons: [
                          DialogButton(
                            child: Text('Okay',style: TextStyle(
                              color: AppColors.primaryWhite
                            ),),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            width: 50.0,
                          )
                        ]
                    ).show();

                  }else{
                    pd.show();
                    FirebaseAuth.instance.signInWithEmailAndPassword(email: username.text.toString(),
                        password: password.text.toString())
                        .then((suc) async{
                      User user=FirebaseAuth.instance.currentUser;
                      var id=user.uid;
                      print('here is the user id $id');
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>homeScreen(mediaQuery: mediaQuery,)));
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
                      child: Text('Login',style: TextStyle(
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
                    Text('Don\'t have an account ',style: TextStyle(
                        color: AppColors.primaryDark,fontSize: 15,decoration: TextDecoration.none
                    ),),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>signupScreen()));
                      },
                      child: Text('Sign up',style: TextStyle(
                          color: AppColors.primaryDarkColor,fontSize: 15,decoration: TextDecoration.underline
                      ),),
                    ),
                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
