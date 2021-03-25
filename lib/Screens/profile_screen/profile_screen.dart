import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mycart/Values/app_colors.dart';
import 'package:mycart/custom_widgets/cart_payment_card.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Box box;
  var _firstName = "";
  var email = "";
  var phone="";

  initHive() async{
    box= await Hive.openBox("SelectedProducts");
    setState(() {
      _firstName=box.get("UserName");
      email=box.get("Email");
      phone=box.get("Phone");
    });
  }

  @override
  void initState() {
    initHive();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryDarkColor,
        title: Text(
          'Profile',
          style: TextStyle(
            color: AppColors.primaryWhite,
            fontSize: 15,
          ),
        ),
      ),
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30.0,),
              Container(
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
              SizedBox(height: 20.0,),
              Text(
                "$_firstName",
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 75.0,),
              Container(
                height: height*0.35,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.only(left:15.0,right: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      cardPaymentdetails(
                        text1: "User name",
                        text2: "$_firstName",
                      ),
                      cardPaymentdetails(
                        text1: "Email",
                        text2: "$email",
                      ),
                      cardPaymentdetails(
                        text1: "Gender",
                        text2: "Male",
                      ),
                      cardPaymentdetails(
                        text1: "Languages",
                        text2: "English, Tamil",
                      ),
                      cardPaymentdetails(
                        text1: "Phone",
                        text2: "$phone",
                      ),
                      // cardPaymentdetails(
                      //   text1: "Date of Birth",
                      //   text2: "19.03.2000",
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.0,),
              Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  width:width*0.9,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: AppColors.primaryDarkColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: Text(
                      'EDIT PROFILE',
                      style: TextStyle(
                          fontSize: 15.0, color: AppColors.primaryWhite),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
