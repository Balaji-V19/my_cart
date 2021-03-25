import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mycart/Values/app_colors.dart';


class myCartWidget extends StatelessWidget {
  var img,name,price,count;
  myCartWidget({this.price,this.name,this.img,this.count});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top:15.0),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          width: width*0.9,
          decoration: BoxDecoration(
            color: AppColors.primaryWhite,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  height: (width - 20) * 0.2,
                  width: (width - 20) * 0.2,
                  color: AppColors.primaryLightColor,
                  child: CachedNetworkImage(
                    imageUrl: img,
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: width*0.5,
                      child: Text(
                        '$name',
                        style: TextStyle(
                            fontSize: 12.0,
                            color: AppColors.primaryDarkColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      width: width*0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            '₹ $price',
                            style: TextStyle(
                                fontSize: 12.0, color: AppColors.primaryDark),
                            overflow: TextOverflow.ellipsis,
                          ),

                          Material(
                            borderRadius: BorderRadius.circular(15.0),
                            elevation: 4.0,
                            child: Container(
                              height: 35.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: AppColors.primaryWhite,
                              ),
                              child: Row(
                                children: [
                                  IconButton(icon: Icon(Icons.add,
                                    color: AppColors.primaryDark,size: 20.0,), onPressed: (){

                                  }),
                                  count>0?Text('$count',style: TextStyle(
                                      fontSize: 15.0, color: AppColors.primaryDark),
                                    overflow: TextOverflow.ellipsis,):Container(),
                                  IconButton(icon: Icon(Icons.remove,color: AppColors.primaryDark,size: 20.0,),
                                      onPressed: (){
                                  }),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
