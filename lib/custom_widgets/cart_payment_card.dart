import 'package:flutter/material.dart';
import 'package:mycart/Values/app_colors.dart';


class cardPaymentdetails extends StatelessWidget {
  var text1,text2;
  cardPaymentdetails({this.text1,this.text2});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$text1',
          style: TextStyle(
              fontSize: 15.0, color: AppColors.primaryDark),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          '$text2',
          style: TextStyle(
              fontSize: 15.0, color: AppColors.primaryDarkColor),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
