import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycart/Values/app_colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';


class ChatView extends StatefulWidget {
  var id,ImgUrl,name;
  ChatView({this.id,this.name,this.ImgUrl});
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  var uid;
  var translator = GoogleTranslator();
  TextEditingController msg,ttle,flname;
  List<Widget> list = [];
  var listMessage;
  ScrollController _scrollController=ScrollController();
  var isLoading = true;
  var userRoomId;
  String userdata='';
  DateTime _dateTimet=DateTime.fromMillisecondsSinceEpoch(int.parse(DateTime.now().millisecondsSinceEpoch.toString()));
  bool me=false;

  Future<void> getData() async {
    User user=FirebaseAuth.instance.currentUser;
    setState(() {
      uid = user.uid;
      userdata=uid;
    });
    if(widget.id.hashCode<uid.hashCode){
      setState(() {
        userRoomId='${widget.id}-$uid';
      });
    }
    else{
      setState(() {
        userRoomId='$uid-${widget.id}';
      });
    }
    print('here is the uid $userRoomId');

  }

  Future<void> Sendmsg(String msg,String ui,String userRoomId,String currentUserId) async{
    FirebaseFirestore.instance.collection('/Messages').doc('$userRoomId').
    collection('$userRoomId').add({'Sender':currentUserId,'Receiver':ui,'Message':msg,'timestamp':
    DateTime.now().millisecondsSinceEpoch.toString()}).catchError((e){
      print(e);
    });
  }

  Future<void> callback() async{
    Sendmsg(msg.text, widget.id,userRoomId,uid);
    msg.clear();
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }
  Future<void> some() async{
    User user=FirebaseAuth.instance.currentUser;
    setState(() {
      userdata=user.uid.toString();
    });
  }


  @override
  void initState() {
    super.initState();
    msg=TextEditingController(text: '');
    ttle=TextEditingController(text: '');
    flname=TextEditingController(text: '');
    getData();
  }

  Widget buildItem(int index, DocumentSnapshot document,double width) {
    var now=document['timestamp'];
    var selected=false;
    var messageText=document['Message'];
    var today=new DateTime.now().millisecondsSinceEpoch.toString();
    DateTime tody=DateTime.fromMillisecondsSinceEpoch(int.parse(today));
    bool td=false,to=false;
    DateTime dd=DateTime.fromMillisecondsSinceEpoch(int.parse(now));
    if(DateFormat("dd/MM/yyyy").format(dd)!=DateFormat("dd/MM/yyyy").format(tody) &&
        DateFormat("dd/MM/yyyy").format(dd)!=DateFormat("dd/MM/yyyy").format(_dateTimet)){
      td=true;
    }
    if(DateFormat("dd/MM/yyyy").format(dd)==DateFormat("dd/MM/yyyy").format(tody) &&
        DateFormat("dd/MM/yyyy").format(dd)!=DateFormat("dd/MM/yyyy").format(_dateTimet)){
      to=true;
    }
    if(document['Sender']==userdata){
      me=true;
    }else{
      me=false;
    }
    _dateTimet=dd;

    return Column(
      crossAxisAlignment: me?CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: <Widget>[
        td?Center(child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.grey),
          padding: EdgeInsets.only(left: 10.0,top: 10.0,right: 10.0,bottom: 10.0),
          child: Text(DateFormat("dd/MM/yyyy").format(dd),style: TextStyle(
            fontSize: 10.0,
          ),),
        )):to?Center(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.grey),
            padding: EdgeInsets.only(left: 10.0,top: 10.0,right: 10.0,bottom: 10.0),
            child: Text('Today',style: TextStyle(
              fontSize: 10.0,
            ),),
          ),
        ):Text(''),
        SizedBox(height: 10.0,),
        Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            onTap: () async{
              setState(() {
                selected=true;
              });
              await "$messageText".translate(to: 'ta').then((value){
                setState(() {
                  messageText=value;
                  selected=false;
                });
              });
              Alert(
                  context: context,
                  title: 'Translation',
                  desc: '$messageText',
                  type: AlertType.warning,
                  buttons: [
                    DialogButton(
                      child: Text('Okay'),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      width: 50.0,
                    )
                  ]
              ).show();
              print("$messageText and $selected");
            },
            child: Container(
              child: Text(
                "$messageText",
                style: TextStyle(
                  color:me?Colors.black:Colors.white,
                  fontSize: 15.0,
                ),
              ),
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              decoration: BoxDecoration(color: me?AppColors.primaryWhite:AppColors.primaryDarkColor,
                  borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        ),
        SizedBox(height: 10.0,),
        InkWell(
          onTap: (){
            print('here is second $messageText');
          },
          child: Text( DateFormat('h:mm a').format(dd),
            style: TextStyle(
              fontSize: 10.0,
            ),),
        ),
        SizedBox(height: 10.0,),
        InkWell(
          onTap: () async{
            setState(() {
              selected=true;
            });
            await "$messageText".translate(to: 'ta').then((value){
              setState(() {
                messageText=value;
                selected=false;
              });
            });
            Alert(
                context: context,
                title: 'Translation',
                desc: '$messageText',
                type: AlertType.warning,
                buttons: [
                  DialogButton(
                    child: Text('Okay'),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    width: 50.0,
                  )
                ]
            ).show();
            print("$messageText and $selected");
          },
          child: Text( selected?"$messageText":"See Translation",
            style: TextStyle(
              fontSize: 12.0,
            ),),
        ),
        SizedBox(height: 20.0,),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryDarkColor,
        title: Text(widget.name),
        // actions: <Widget>[
        //   //todo here is the popup menu
        //   PopupMenuButton<String>(
        //       elevation: 3.0,
        //       onSelected: _selected,
        //       itemBuilder:(BuildContext context){
        //         return dt.map((f){
        //           return PopupMenuItem<String>(
        //             value: f,
        //             child: Text(f),
        //           );
        //         }).toList();
        //       }
        //   ),
        //   SizedBox(width: 20.0,),
        // ],
      ),
      body:Center(
        child: SingleChildScrollView(
          controller: _scrollController,
          reverse: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: height*0.836,
                width: width,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Messages')
                      .doc(userRoomId)
                      .collection("$userRoomId")
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: Text(''));
                    } else {
                      listMessage = snapshot.data.documents;
                      return ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemBuilder: (context, index) => buildItem(index, snapshot.data.documents[index],width),
                        itemCount: snapshot.data.documents.length,
                        reverse: true,
                      );
                    }
                  },
                ),

              ),

              Center(
                child: Container(
                  width: width,
                  color: AppColors.primaryDarkColor,
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget>[
                        SizedBox(width: 10.0,),
                        Expanded(
                          child: TextField(
                            controller: msg,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: AppColors.primaryWhite
                            ),
                            decoration: InputDecoration(
                                hintText: 'Type your message',
                                hintStyle: TextStyle(
                                    fontSize: 20.0,
                                  color: AppColors.primaryWhite
                                ),
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.send, size: 20.0,color: AppColors.primaryWhite),
                            onPressed: callback
                        ),
                      ]
                  ),

                ),
              ),
              // SizedBox(height: 30.0,),
            ],
          ),
        ),
      ),
    );
  }

}
