import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mycart/Screens/home_screen/product_dropdown.dart';
import 'package:mycart/Screens/select_product/select_product.dart';
import 'package:mycart/Values/app_colors.dart';


class homeScreenProducts extends StatelessWidget {
  var mediaQuery,res,name,img,price,isCreate=false,index;
  homeScreenProducts({this.name,this.img,this.mediaQuery,this.price,this.res,this.isCreate,this.index});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      child: InkWell(
        onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProductDropDown(
                          mediaQuery: mediaQuery,
                          products: res,
                          name: name,
                        )));
        },
        child: Container(
          width: mediaQuery.width,
          color: AppColors.primaryLightColor,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,left: 15.0
            ),
            child: Row(
              children: <Widget>[
                Container(
                  height: (mediaQuery.width - 20) * 0.23,
                  width: (mediaQuery.width - 20) * 0.23,
                  color: AppColors.primaryLightColor,
                  child: CachedNetworkImage(
                    imageUrl: img,
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
                SizedBox(width: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: mediaQuery.width*0.5,
                      child: Text(
                        '$name',
                        style: TextStyle(
                            fontSize: 12.0,
                            color: AppColors.primaryDarkColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '₹ $price',
                      style: TextStyle(
                          fontSize: 12.0, color: AppColors.primaryDark),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
