import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mycart/Screens/chat_screen/chat_screen.dart';
import 'package:mycart/Screens/profile_screen/profile_screen.dart';
import 'package:mycart/Values/app_colors.dart';

class AppDrawer extends StatefulWidget {
  final statusBarHeight;

  AppDrawer(this.statusBarHeight);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var keySelected = -1;
  var balance;
  var faqLink;
  Box box;
  var _firstName = "";
  var _lastName = "";

  initHive() async{
    box= await Hive.openBox("SelectedProducts");
    setState(() {
      _firstName=box.get("UserName");
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  /// Returns a image widget
  Widget leadingIcon(image) {
    return Container(
      width: 20,
      height: 20,
      child: Image.asset(
        image,
        fit: BoxFit.contain,
      ),
    );
  }

  /// Returns title text widget
  Widget titleText(text) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: AppColors.primaryWhite,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }


  Widget _buildListTile(
      {leading,
      title,
      trailing,
      onTap,
      color = AppColors.primaryDark,
      balance}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: color,
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Row(
          children: <Widget>[
            leading,
            SizedBox(
              width: 20,
            ),
            title ?? Container(),
            Spacer(),
            balance ?? Container(),
            balance == null
                ? Container()
                : SizedBox(
                    width: 5,
                  ),
            trailing ?? Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.clear,
            color: AppColors.primaryWhite,
            size: 30,
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }



  @override
  void initState() {
    initHive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Container(
      height: mediaQuery.size.height,
      width: mediaQuery.size.width*0.7,
      child: Drawer(
        child: Container(
          color: AppColors.primaryDarkColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: widget.statusBarHeight,
              ),
              _buildHeader(context),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                },
                child: Container(
                  width: width,
                  height: height*0.2,
                  decoration: BoxDecoration(
                    color: AppColors.primaryWhite,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
                      )
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                "$_firstName",
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              Container(
                width: width,
                height: height*0.5,
                child: Padding(
                  padding: const EdgeInsets.only(left:30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Home",
                        style: TextStyle(
                          color: AppColors.primaryWhite,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Products",
                        style: TextStyle(
                          color: AppColors.primaryWhite,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
                        },
                        child: Text(
                          "Chat",
                          style: TextStyle(
                            color: AppColors.primaryWhite,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Your Order",
                        style: TextStyle(
                          color: AppColors.primaryWhite,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                        },
                        child: Text(
                          "Settings",
                          style: TextStyle(
                            color: AppColors.primaryWhite,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Terms & Conditions",
                        style: TextStyle(
                          color: AppColors.primaryWhite,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Privacy policy",
                        style: TextStyle(
                          color: AppColors.primaryWhite,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () async{
                          await FirebaseAuth.instance.signOut();
                        },
                        child: Text(
                          "Log out",
                          style: TextStyle(
                            color: AppColors.primaryWhite,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(
                flex: 3,
              ),
              Text(
                "Version 1.0.0",
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                },
                child: Text(
                  "Terms and Conditions",
                  style: TextStyle(
                      color: AppColors.primaryWhite,
                      fontSize: 15,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
