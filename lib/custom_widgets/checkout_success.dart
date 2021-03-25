import 'package:flutter/material.dart';
import 'package:mycart/Screens/chat_screen/chat_screen.dart';
import 'package:mycart/Screens/home_screen/home_screen.dart';
import 'package:mycart/Values/app_colors.dart';
import 'package:mycart/Values/image_assets.dart';
import 'package:mycart/main.dart';

class CheckOutSuccess extends StatefulWidget {
  var mediaQuery;
  CheckOutSuccess({this.mediaQuery});
  @override
  _CheckOutSuccessState createState() => _CheckOutSuccessState();
}

class _CheckOutSuccessState extends State<CheckOutSuccess> {

  var textShow=false;



  navigateToNextScreen() {
    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      setState(() {
        textShow=true;
      });
      Future.delayed(Duration(milliseconds: 4500)).then((value) {
        setState(() {
          selectedDetails={};
          selectedList=[];
        });
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: AppColors.primaryDarkColorShade,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: (width - 20) ,
              width: (width - 20),
              // color: AppColors.primaryLightColor,
              child: Image.asset(ImageUrl.created,fit: BoxFit.cover,),
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
