import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mycart/Values/app_colors.dart';


class selectProducts extends StatefulWidget {
  var name,res,index;
  selectProducts({this.res,this.name,this.index});
  @override
  _selectProductsState createState() => _selectProductsState();
}

class _selectProductsState extends State<selectProducts> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryDarkColor,
        title: Text(
          'MY CART',
          style: TextStyle(
            color: AppColors.primaryWhite,
            fontSize: 15,
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        color: AppColors.primaryWhite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: (width - 20),
                width: (width - 20),
                color: AppColors.primaryLightColor,
                child: CachedNetworkImage(
                  imageUrl:widget.res['products'][widget.index]['images'][0]['src'],
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left:15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${widget.res['products'][widget.index]['title']}',
                      style: TextStyle(
                          fontSize: 12.0,
                          color: AppColors.primaryDarkColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '₹ ${widget.res['products'][widget.index]['variants'][0]['price']}',
                      style: TextStyle(
                          fontSize: 12.0, color: AppColors.primaryDark),
                      overflow: TextOverflow.ellipsis,
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
