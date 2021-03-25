import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mycart/Screens/home_screen/home_screen.dart';
import 'package:mycart/Values/app_colors.dart';
import 'package:mycart/Values/image_assets.dart';
import 'package:path_provider/path_provider.dart';

import 'Screens/login_screen/login_screen.dart';

var count=0;
var selectedDetails={};
var selectedList=[];

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox("SelectedProducts");
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomePage(title: 'Flutter Demo Home Page'),
  ));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var textShow=false;



  navigateToNextScreen() {
    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      setState(() {
        textShow=true;
      });
      Future.delayed(Duration(milliseconds: 4500)).then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => checkuser()));
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: AppColors.primaryDarkShade,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: (width - 20) * 0.5,
              width: (width - 20) * 0.5,
             // color: AppColors.primaryLightColor,
              child: Image.asset(ImageUrl.cartGif,fit: BoxFit.cover,),
              // child: CachedNetworkImage(
              //   imageUrl: ImageUrl.cartGif,
              //   fit: BoxFit.contain,
              //   errorWidget: (context, url, error) =>
              //   const Icon(Icons.error),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

class checkuser extends StatefulWidget {
  @override
  _checkuserState createState() => _checkuserState();
}

class _checkuserState extends State<checkuser> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return loginScreen();
        } else {
          return homeScreen(
            mediaQuery: mediaQuery,
          );
        }
      },
    );
  }
}
