import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mycart/Screens/cart_screen/my_cart.dart';
import 'package:mycart/Values/app_colors.dart';
import 'package:mycart/custom_widgets/details_products.dart';
import 'package:mycart/custom_widgets/homeScreenProducts.dart';

import '../../main.dart';

class ProductDropDown extends StatefulWidget {
  var products,mediaQuery,name;
  ProductDropDown({this.mediaQuery,this.products,this.name});
  @override
  _ProductDropDownState createState() => _ProductDropDownState();
}

class _ProductDropDownState extends State<ProductDropDown> {
  List<Widget> list = [];
  var isLoading = true;
  Box box;

  initHive() async{
    box=await Hive.openBox("SelectedProducts");
  }

  getTheProducts(){
    for(var i=0;i+1<widget.products['products'].length;i+=2){
      setState(() {
        list.add(
          Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                productDetails(
                  price: widget.products['products'][i]['variants'][0]['price'],
                  name: widget.products['products'][i]['title'],
                  mediaQuery: widget.mediaQuery,
                  img: widget.products['products'][i]['images'][0]['src'],
                  res: widget.products,
                  // index: i,
                  // isCreate: true,
                ),
                productDetails(
                  price: widget.products['products'][i+1]['variants'][0]['price'],
                  name: widget.products['products'][i+1]['title'],
                  mediaQuery: widget.mediaQuery,
                  img: widget.products['products'][i+1]['images'][0]['src'],
                  res: widget.products,
                  // index: i,
                  // isCreate: true,
                ),
              ],
            ),
          )
        );
      });
    }
    setState(() {
      list.add(SizedBox(height: 85.0,));
      isLoading=false;
    });
  }

  @override
  void initState() {
    initHive();
    getTheProducts();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryDarkColor,
        title: Text(
          '${widget.name.toString().toUpperCase()}',
          style: TextStyle(
            color: AppColors.primaryWhite,
            fontSize: 15,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
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
                children: list,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: InkWell(
              onTap: (){
                print('here is the stuff $selectedDetails');
                if(selectedList.length>0){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>myCart(mediaQuery: mediaQuery,)));
                }
              },
              child: Material(
                elevation: 4.0,
                child: Container(
                  width: width,
                  height: 55.0,
                  color: AppColors.primaryDarkColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left:10.0,right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Add To Cart',style: TextStyle(
                          color: AppColors.primaryWhite,
                          fontSize: 15,
                        ),
                        ),
                        Icon(Icons.shopping_cart,color: AppColors.primaryWhite,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
