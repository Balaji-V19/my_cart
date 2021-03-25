import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mycart/Values/app_colors.dart';
import 'package:mycart/custom_widgets/cart_payment_card.dart';
import 'package:mycart/custom_widgets/checkout_success.dart';
import 'package:mycart/custom_widgets/my_cart_widget.dart';
import 'package:mycart/main.dart';


class myCart extends StatefulWidget {
  var mediaQuery;
  myCart({this.mediaQuery});
  @override
  _myCartState createState() => _myCartState();
}

class _myCartState extends State<myCart> {
  List<Widget> list = [];
  var isLoading = true;
  var total=0.0;
  var totalCount=0;

  getTheCartDetails(){
    for(var i=0;i<selectedList.length;i++){
      setState(() {
        total+=double.parse(selectedDetails[selectedList[i]][2])*
            selectedDetails[selectedList[i]][3];
        totalCount+=selectedDetails[selectedList[i]][3];
        list.add(
            myCartWidget(
              price: (double.parse(selectedDetails[selectedList[i]][2])*
                  selectedDetails[selectedList[i]][3]).toStringAsFixed(2),
              img:selectedDetails[selectedList[i]][1],
              name: selectedDetails[selectedList[i]][0],
              count: selectedDetails[selectedList[i]][3],
            ),
        );
        // list.add(
        //   Container(
        //     child: Row(
        //       children: [
        //         Container(
        //           height: (widget.mediaQuery.width - 20) * 0.35,
        //           width: (widget.mediaQuery.width - 20) * 0.35,
        //           color: AppColors.primaryLightColor,
        //           child: CachedNetworkImage(
        //             imageUrl: selectedDetails[selectedList[i]][1],
        //             fit: BoxFit.contain,
        //             errorWidget: (context, url, error) =>
        //             const Icon(Icons.error),
        //           ),
        //         ),
        //         SizedBox(width: 20.0),
        //         Column(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: <Widget>[
        //             Text(
        //               '${selectedDetails[selectedList[i]][0]}',
        //               style: TextStyle(
        //                   fontSize: 12.0,
        //                   color: AppColors.primaryDarkColor),
        //               overflow: TextOverflow.ellipsis,
        //             ),
        //             SizedBox(height: 10.0),
        //             Text(
        //               '₹ ${selectedDetails[selectedList[i]][2]}',
        //               style: TextStyle(
        //                   fontSize: 12.0, color: AppColors.primaryDark),
        //               overflow: TextOverflow.ellipsis,
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   )
        // );
      });
    }
    setState(() {
      list.add(SizedBox(height: 30.0,));
      list.add(Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          width: widget.mediaQuery.width*0.9,
          height: widget.mediaQuery.height*0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: AppColors.primaryWhite
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment details',
                  style: TextStyle(
                      fontSize: 18.0, color: AppColors.primaryDarkColor),
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                cardPaymentdetails(text1:'No. of items',text2: '$totalCount',),
                Spacer(),
                cardPaymentdetails(text1:'Subtotal',text2:  '₹ ${total.toStringAsFixed(2)}',),
                Spacer(),
                cardPaymentdetails(text1:'Delivery charges',text2: '₹ 20.0',),
                Spacer(),
                cardPaymentdetails(text1:'Total Amount',text2: '₹ ${(total+20.0).toStringAsFixed(2)}',),
                Spacer(),
              ],
            ),
          ),
        ),
      ));
      list.add(SizedBox(height: 30.0,));
      list.add(InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOutSuccess(mediaQuery: widget.mediaQuery,)));
        },
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            width: widget.mediaQuery.width*0.9,
            height: 40.0,
            decoration: BoxDecoration(
              color: AppColors.primaryDarkColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Center(
              child: Text(
                'CHECKOUT',
                style: TextStyle(
                    fontSize: 15.0, color: AppColors.primaryWhite),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ));
      list.add(SizedBox(height: 30.0,));
      isLoading=false;
    });
  }

  @override
  void initState() {
    getTheCartDetails();
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
    );
  }
}
