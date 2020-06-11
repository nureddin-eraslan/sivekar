import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:share/share.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sivekar/audio.dart';
import 'package:sivekar/siir_details.dart';

import 'services/advert_services.dart';

class YeniSiirDetay extends StatefulWidget {
final DocumentSnapshot siir;

  const YeniSiirDetay({Key key, this.siir}) : super(key: key);

  @override
  _YeniSiirDetayState createState() => _YeniSiirDetayState();
}

class _YeniSiirDetayState extends State<YeniSiirDetay> {
  Future getSiir() async{
    var firestore=Firestore.instance;
    QuerySnapshot qn= await firestore.collection("yazar eser").getDocuments();
    return qn.documents;
  }
  final AdvertService _advertService =AdvertService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.pink,),
          onPressed: (){
            Navigator.pop(context);
          },

        ),
        actions: <Widget>[
          Container(
            height: 20,width: 50,
            child: IconButton(
                icon: Icon(Icons.share,color: Colors.pink,),
                onPressed: (){
                  final RenderBox box = context.findRenderObject();
                  Share.share(
                 "ŞiveKarın Sesi:Şiir Uygulaması\n\n"+widget.siir.data['eser_isim']+"\n Adlı Şiiri Seninle Paylaşma istedim: \n\n"+
                          widget.siir.data['eser_yazı'],

                      sharePositionOrigin:
                      box.localToGlobal(Offset.zero) &
                      box.size);
                }
            ),
          )
        ],
        title: Text(
          "a",

          style: TextStyle(
              fontFamily: 'Caveat',
              color: Colors.pink,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: Container(

        child: FutureBuilder(

          builder: (BuildContext context,snapshot){
        return PageView.builder(
           scrollDirection: Axis.horizontal,
            itemBuilder:(BuildContext context,int index){
              return Container(
                child: Center(
                  child: Text("a" ),
                ),
              );
            },
        );
          },
        ),
      )
    );
  }
  sesGetir(){
  return Auido();
  }
}
