import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mycart/Screens/home_screen/product_dropdown.dart';
import 'package:mycart/Values/app_colors.dart';


class CategoryList extends StatelessWidget {
  var img,name,price,mediaQuery,res;
  CategoryList({this.img,this.name,this.price,this.mediaQuery,this.res});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(10.0),
            color: AppColors.primaryWhite,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDropDown(
                            mediaQuery: mediaQuery,
                            products: res,
                            name:name,
                          )));
                },
                child: Container(
                  width: mediaQuery.width * 0.4,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLightColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: (mediaQuery.width - 20) * 0.35,
                        width: (mediaQuery.width - 20) * 0.35,
                        color: AppColors.primaryLightColor,
                        child: CachedNetworkImage(
                          imageUrl: img,
                          fit: BoxFit.contain,
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${name.toString().toUpperCase()}',
                            style: TextStyle(
                                fontSize: 12.0,
                                color: AppColors.primaryDarkColor),
                            overflow: TextOverflow.ellipsis,
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
          ),
        ],
      ),
    );
  }
}

