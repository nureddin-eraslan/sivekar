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
import 'package:sivekar/siir_details.dart';
import 'package:sivekar/yeni_siir_detail.dart';

import 'services/advert_services.dart';

typedef void OnError(Exception exception);
enum PlayerState { stopped, playing, paused }
const kUrl="https://firebasestorage.googleapis.com/v0/b/hikayem-d5343.appspot.com/o/WhatsApp%20Audio%202020-05-20%20at%2018.56.11%20(online-audio-converter.com).mp3?alt=media&token=7e0a4722-753f-41e3-9e06-d37b76d522d3";


class Details extends StatefulWidget {
  final DocumentSnapshot seyahat;

  const Details({Key key, this.seyahat}) : super(key: key);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  Future getSiir() async{
    var firestore=Firestore.instance;
    QuerySnapshot qn= await firestore.collection("yazar eser").getDocuments();
    return qn.documents;
  }
  navigateToSiirDetay(DocumentSnapshot siir) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (index) => YeniSiirDetay(
              siir: siir,
            )));
  }
  final AdvertService _advertService = AdvertService();
  double _lowerValue = 50;
  double _upperValue = 180;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
backgroundColor: Colors.grey.shade800,
      /* bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Colors.pink,
          items: <Widget>[
            Icon(Icons.add, size: 30,color: Colors.white, ),
            Icon(Icons.list, size: 30,color: Colors.white, ),
            Icon(Icons.compare_arrows, size: 30,color: Colors.white,),
          ],


          onTap: (index) {
            //Handle button tap

          },
        ),*/
        appBar: AppBar(
          backgroundColor: Colors.grey.shade800,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
            onPressed: (){
              Navigator.pop(context);
            },

          ),
          actions: <Widget>[
            Container(
              height: 20,width: 50,
              child: IconButton(
                  icon: Icon(Icons.share,color: Colors.white,),
                  onPressed: (){
                    final RenderBox box = context.findRenderObject();
                    Share.share(
                        "ŞiveKarın Sesi:Şiir Uygulaması\n\n"+widget.seyahat.data['yazar isim']+"\n Adlı Yazarın Hayatını Seninle Paylaşma istedim: \n\n"+
                            widget.seyahat.data['kısa bilgi'],

                        sharePositionOrigin:
                        box.localToGlobal(Offset.zero) &
                        box.size);
                  }
              ),
            )
          ],
          title: Text(widget.seyahat.data['yazar isim'],
            style: TextStyle(
                fontFamily: 'Caveat',
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
        ),

        body:

        Container(

          child: Stack(
            children: <Widget>[

              SingleChildScrollView(
                child: Container(

                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                     Container(
                       margin: EdgeInsets.only(top:15),
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         //  borderRadius: BorderRadius.circular(10),
                           image: DecorationImage(
                           image: NetworkImage(widget.seyahat.data['iç resim']),

                           
                         )
                       ),
                       height: 180,

                     ),

                      Container(
                         margin: EdgeInsets.only(top: 20,bottom: 15),
                          color: Colors.pink,
                         height: 250,
                          padding: EdgeInsets.all(20),
                          child: Text(
                              widget.seyahat.data['kısa bilgi'],
                              style: TextStyle(
                                fontSize: 16.toDouble(),
                                color: Colors.white
                              ))),

                      Container(
                        //bu container başlıca eser yazılan genel container
                        height: 50,
                        //color: Colors.yellow,
                        child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                  'Eserleri',style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:25
                              ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child: Text(
                                'Eserleri',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:15
                              ),
                              ),
                            ),
                          ],
                        ),
                      ),
Container(
  child:


        Container(
        color: Colors.pink,
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder:(BuildContext context ,int index){

            return GestureDetector(
              onTap: (){
                navigateToSiirDetay(widget.seyahat.data['eser_isim'][index]);
              },
              child: Container(

                height: 80,width: 120,

                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(15),
                ),

                margin: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 90,width: 120,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                       image: DecorationImage(
                         image: NetworkImage(widget.seyahat.data['eser_resim'][index]),
                         fit: BoxFit.cover
                       )

                      ),
                    ),
                    Container(
                      child: Text(widget.seyahat.data['eser_isim'][index]),
                    )
                  ],
                ),
              ),
            );
          },itemCount: 5,
        ),
      )



),
                      SizedBox(height: 10,),

                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );

  }


}

class EserlerinSayfasi extends StatefulWidget {
 final DocumentSnapshot siir;

  const EserlerinSayfasi({Key key, this.siir}) : super(key: key);
  @override
  _EserlerinSayfasiState createState() => _EserlerinSayfasiState();
}

class _EserlerinSayfasiState extends State<EserlerinSayfasi> {


  navigateToSiirDetay(DocumentSnapshot siir) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => YeniSiirDetay(
              siir: siir,
            )));
  }
  Future getSiir() async{
    var firestore=Firestore.instance;
    QuerySnapshot qn= await firestore.collection("yazar eser").getDocuments();
    return qn.documents;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSiir(),
      builder: (_,snapshot){
        return Container(
          color: Colors.pink,
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder:(BuildContext context ,int index){

              return GestureDetector(
                onTap: (){
                  navigateToSiirDetay(snapshot.data[index]);
                },
                child: Container(

                  height: 80,width: 120,

                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(15),
                  ),

                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 90,width: 120,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),


                        ),
                      ),
                      Container(
                        child: Text(widget.siir.data['eser_isim'][index]),
                      )
                    ],
                  ),
                ),
              );
            },itemCount: snapshot.data['eser_isim'].length,
          ),
        );
      },
    );
  }
}






