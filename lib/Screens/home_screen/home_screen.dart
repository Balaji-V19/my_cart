import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mycart/Screens/home_screen/drawer_widget.dart';
import 'package:mycart/Screens/home_screen/product_dropdown.dart';
import 'package:mycart/Values/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:mycart/custom_widgets/category_list.dart';
import 'package:mycart/custom_widgets/homeScreenProducts.dart';

class homeScreen extends StatefulWidget {
  var mediaQuery;
  homeScreen({this.mediaQuery});
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  List<Widget> list = [];
  var isLoading = true;
  Box box;
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('UserDetails');
  var uid;

  initHive() async{
    box= await Hive.openBox("SelectedProducts");
    getTheAttaProduct();
    getData();
  }

  Future<void> getData() async {
    // Get docs from collection reference
    User user=FirebaseAuth.instance.currentUser;
    setState(() {
      uid = user.uid;
    });
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      for(var i=0;i<allData.length;i++){
        if(allData[i]['UserId']==uid){
          box.put("UserName", allData[i]['UserName']);
          box.put("Email", allData[i]['Email']);
          box.put("Phone", allData[i]['Phone']);
        }
      }
      isLoading=false;
    });
    print(allData);
  }

  getTheAttaProduct() async {
    var item = [
      'atta',
      'bakery',
      'baking',
      'basmati-rice',
      'beauty',
      'biscuits-cookies',
      'butter',
      'candy-chocolate',
      'canned-foods',
      'cheese-tofu',
      'chutneys-spreads',
      'coffee',
      'cooked-food',
      'cream',
      'drink-mixes',
      'eggs',
      'flours',
      'frozen-foods',
      'frozen-vegetables',
      'fruits',
      'ghee',
      'grocery',
      'ground-spices',
      'hair-care',
      'health-care',
      'health-drinks',
      'idly-rice',
      'indian-snacks',
      'instant-drink-mix',
      'instant-drinks',
      'instant-mixes',
      'instant-noodles',
      'jaggery',
      'ketchup-sauces',
      'lentils',
      'masala',
      'milk',
      'millets-and-grains',
      'nuts-seeds',
      'oil',
      'other-rice',
      'paneer',
      'papad',
      'peas',
      'pickle',
      'ponni-boiled-rice',
      'ponni-raw-rice',
      'pooja-accessories',
      'ready-to-eat',
      'salt',
      'sona-masoori-rice',
      'sugar',
      'sweets',
      'tea',
      'vegetables',
      'whole-spices',
      'yogurt',
      'yogurt-drinks'
    ];
    List<Widget> listRow = [];
    setState(() {
      list.add(
        Padding(
          padding: const EdgeInsets.only(top:15.0,left: 15.0),
          child: Text(
            'Category',
            style: TextStyle(
                fontSize: 21.0,fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    });
    for (var j = 0; j < 7; j += 2) {
      var item1=box.get("${item[j]}");
      var item2=box.get("${item[j+1]}");
      if(item1!=null && item2!=null){
        setState(() {
          list.add(
            Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryList(img:item1['products'][0]['images'][0]['src'],
                    mediaQuery: widget.mediaQuery,name: item[j],price:
                    item1['products'][0]['variants'][0]['price'],res: item1,),
                  CategoryList(img:item2['products'][0]['images'][0]['src'],
                      mediaQuery: widget.mediaQuery,name: item[j+1],price:
                      item2['products'][0]['variants'][0]['price'],res:item2),
                ],
              ),
            ),
          );
        });
      }
      else{
      var url =
          "https://store2k.com/collections/${item[j]}/products.json?page=1";
      var urls =
          "https://store2k.com/collections/${item[j + 1]}/products.json?page=1";
      try {
        final response = await http.get(url);
        final responses = await http.get(urls);
        var res = json.decode(response.body);
        var res2 = json.decode(responses.body);
        setState(() {
          box.put("${item[j]}", res);
          box.put("${item[j+1]}", res2);
          list.add(
            Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryList(img:res['products'][0]['images'][0]['src'],
                  mediaQuery: widget.mediaQuery,name: item[j],price:
                    res['products'][0]['variants'][0]['price'],res: res,),
                  CategoryList(img:res2['products'][0]['images'][0]['src'],
                    mediaQuery: widget.mediaQuery,name: item[j+1],price:
                    res2['products'][0]['variants'][0]['price'],res:res2),
                ],
              ),
            ),
          );
        });
      } catch (e) {
        print(e);
      }}
    }
    setState(() {
      list.add(SizedBox(height: 20.0,));
      list.add(
        Padding(
          padding: const EdgeInsets.only(top:15.0,left: 15.0),
          child: Text(
            'Products',
            style: TextStyle(
                fontSize: 21.0,fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
      list.add(SizedBox(height: 20.0,));
    });
    for (var j = 8; j < 27; j++) {
      var item1=box.get(item[j]);
      if(item1!=null){
        setState(() {
          list.add(
            homeScreenProducts(
              price: item1['products'][0]['variants'][0]['price'],
              name: item[j],
              mediaQuery: widget.mediaQuery,
              img: item1['products'][0]['images'][0]['src'],
              res: item1,
              isCreate: false,
            ),
          );
        });
      }
      else {
        var url =
            "https://store2k.com/collections/${item[j]}/products.json?page=1";
        try {
          final response = await http.get(url);
          var res = json.decode(response.body);
          print("Balance here $res");
          setState(() {
            box.put("${item[j]}", res);
            list.add(
              homeScreenProducts(
                price: res['products'][0]['variants'][0]['price'],
                name: item[j],
                mediaQuery: widget.mediaQuery,
                img: res['products'][0]['images'][0]['src'],
                res: res,
                isCreate: false,
              ),
            );
          });
        } catch (e) {
          print(e);
        }
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initHive();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      drawer: AppDrawer(mediaQuery.padding.top),
      appBar: AppBar(
        backgroundColor: AppColors.primaryDarkColor,
        title: Text(
          'Home',
          style: TextStyle(
            color: AppColors.primaryWhite,
            fontSize: 15,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: ()async{
          return false;
        },
        child: Container(
          height: height,
          width: width,
          color: AppColors.primaryLightColor,
          child: isLoading
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: list,
                  ),
                ),
        ),
      ),
    );
  }
}
