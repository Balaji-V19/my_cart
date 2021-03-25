import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mycart/Values/app_colors.dart';
import 'package:mycart/custom_widgets/chat_tail.dart';


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var uid;
  List<Widget> list = [];
  var isLoading = true;
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('UserDetails');

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
        if(allData[i]['UserId']!=uid) {
          list.add(ChatTail(
            img: allData[i]['ImageUrl'],
            name: allData[i]['UserName'],
            id: allData[i]['UserId'],
          ));
        }
      }
      isLoading=false;
    });
    print(allData);
  }


  @override
  void initState() {
    super.initState();
    getData();
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
          'Chat',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: list,
          ),
        ),
      ),
    );
  }
}
