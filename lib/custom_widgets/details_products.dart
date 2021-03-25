import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mycart/Values/app_colors.dart';

import '../main.dart';


class productDetails extends StatefulWidget {
  var img,name,price,mediaQuery,res;
  productDetails({this.name,this.res,this.mediaQuery,this.price,this.img});

  @override
  _productDetailsState createState() => _productDetailsState();
}

class _productDetailsState extends State<productDetails> {
  var productCount=0;

  getTheProductCount(){
    if(selectedDetails['${widget.img}']!=null){
      productCount=selectedDetails['${widget.img}'][3];
    }
  }

  @override
  void initState() {
    getTheProductCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: width*0.45,
      child: Column(
        children: [
          Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(10.0),
            color: AppColors.primaryWhite,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width * 0.4,
                decoration: BoxDecoration(
                  color: AppColors.primaryLightColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Container(
                      height: (width - 20) * 0.35,
                      width: (width - 20) * 0.35,
                      color: AppColors.primaryLightColor,
                      child: CachedNetworkImage(
                        imageUrl: widget.img,
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
                          '${widget.name.toString().toUpperCase()}',
                          style: TextStyle(
                              fontSize: 12.0,
                              color: AppColors.primaryDarkColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                            productCount>0?'₹ ${(double.parse(widget.price)*productCount).toStringAsFixed(2)}':
                          '₹ ${widget.price}',
                          style: TextStyle(
                              fontSize: 12.0, color: AppColors.primaryDark),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: width*0.4,
                      height: 35.0,
                      decoration: BoxDecoration(
                        color: AppColors.primaryDarkColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(icon: Icon(Icons.add,color: AppColors.primaryWhite,size: 20.0,), onPressed: (){
                              setState(() {
                                print('enter $selectedDetails');
                                productCount+=1;
                                selectedDetails['${widget.img}']=['${widget.name}','${widget.img}',
                                  '${widget.price}',productCount];
                                if(!selectedList.contains('${widget.img}')){
                                  selectedList.add('${widget.img}');
                                }
                                if(productCount==0){
                                  selectedList.remove('${widget.img}');
                                  selectedDetails.remove('${widget.img}');
                                }
                              });
                          }),
                          productCount>0?Text('$productCount',style: TextStyle(
                              fontSize: 15.0, color: AppColors.primaryWhite),
                            overflow: TextOverflow.ellipsis,):Container(),
                          IconButton(icon: Icon(Icons.remove,color: AppColors.primaryWhite,size: 20.0,), onPressed: (){
                            if(productCount>0){
                              setState(() {
                                productCount-=1;
                                selectedDetails['${widget.img}']=['${widget.name}','${widget.img}',
                                  '${widget.price}',productCount];
                                if(!selectedList.contains('${widget.img}')){
                                  selectedList.add('${widget.img}');
                                }
                              });
                            }
                            setState(() {
                              if(productCount==0){
                                selectedList.remove('${widget.img}');
                                selectedDetails.remove('${widget.img}');
                              }
                            });
                          }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

