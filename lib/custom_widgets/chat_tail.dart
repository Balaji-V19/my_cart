import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mycart/Screens/chat_screen/chat_view.dart';
import 'package:mycart/Values/app_colors.dart';


class ChatTail extends StatelessWidget {
  var img,name,id;
  ChatTail({this.img,this.name,this.id});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context);
    return InkWell(
      onTap: (){
        User user=FirebaseAuth.instance.currentUser;
        var uid = user.uid;
        var userRoomId;
        if(id.hashCode<uid.hashCode){
            userRoomId='$id-$uid';
        }
        else{
            userRoomId='$uid-$id';
        }
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatView(
          id: id,
          name: name,
          ImgUrl:img,
        )));
      },
      child: Material(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.only(top:15.0),
          child: Container(
            width: width,
            height: 75.0,
            child: Row(
              children: [
                Container(
                  width: 75.0,
                  height: 75.0,
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
                SizedBox(width: 20.0),
                Text(
                  '${name.toString()}',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.primaryDarkColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
