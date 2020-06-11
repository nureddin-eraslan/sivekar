import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sivekar/deneme.dart';
import 'package:sivekar/yeni_siir_detail.dart';
import 'services/advert_services.dart';
import 'siir_details.dart';
import 'tum_sairler_list.dart';
import 'tum_siirler_list.dart';
import 'yazar_detay.dart';
class AnaSayfa extends StatefulWidget {






  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  //final AdvertService _advertService =AdvertService();

  navigateToDetail(DocumentSnapshot seyahat)async {

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Details(
              seyahat: seyahat,
            )));
  }

  navigateToSiirDetay(DocumentSnapshot siir) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SiirDetay(
              siir: siir,
            )));
  }

  Future getPosts() async{
    var _firestore=Firestore.instance;
    QuerySnapshot querySnapshot = await _firestore.collection("yazar_bilgi").getDocuments();
    List<DocumentSnapshot> yazarListe =  querySnapshot.documents;
    return querySnapshot.documents;

  }
  Future getSair() async{
    var firestore=Firestore.instance;
    QuerySnapshot qn= await firestore.collection("yazar eser").getDocuments();
    return qn.documents;
  }
  Future getSiir() async{
    var firestore=Firestore.instance;
    QuerySnapshot qn= await firestore.collection("popüler şiirler").getDocuments();
    return qn.documents;
  }
  @override
  initState(){
    getSiir();
    getSair();
    getPosts();
    //_advertService.showBanner();

    super.initState();
  }
  @override
  dispose(){
    getPosts();
    getSair();
    getSiir();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ŞiveKar'ın Sesi",style: TextStyle(color: Colors.black,fontFamily: 'JotiOne',fontWeight: FontWeight.bold),),centerTitle: true,
        backgroundColor: Colors.white,

      ),
      body:

     SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Popüler Şairler",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>TumSairler()
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 7),
                        child: Text("Tümünü Gör",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pink.shade800),),
                      ),
                    )
                  ],
                ),),
              SizedBox(height: 20,),
              Container(
              //şairlerin bulunduğu büyük container
                height: 260,
                color: Colors.white,
                margin: EdgeInsets.only(top:10),
                child:FutureBuilder(

                  future: getPosts(),
                  builder: (_, snapshot) {
                    if(snapshot.hasError){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(backgroundColor: Colors.orange,),);
                    }
                    else {
                      return ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder:(BuildContext context ,int index){


                            return   Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    navigateToDetail(DocumentSnapshot seyahat)async {

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Details(
                                                seyahat: seyahat,
                                              )));
                                    }
                                    navigateToDetail(snapshot.data[index]);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(0.0, 2.0),
                                              blurRadius: 6.0)
                                        ]),
                                    height: 235,
                                    width: 165,
                                    margin: EdgeInsets.all(8),
                                    //color: Colors.white,
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          height: 145,
                                          width: 165,
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 98,
                                                    right: 75,
                                                    bottom: 20),
                                                height: 20,
                                                color: Colors.black12,
                                                alignment:
                                                Alignment.bottomCenter,
                                                child: Text(
                                               snapshot.data[index],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 18),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Hero(
                                                tag: snapshot.data[index]
                                                    .data['resim'],
                                                child: Container(
                                                  child: Icon(
                                                    Icons.navigation,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                  alignment:
                                                  Alignment.bottomCenter,
                                                  margin: EdgeInsets.only(
                                                      top: 115, right: 115),
                                                ),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data[index]
                                                    .data['resim']),
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 145),
                                          alignment: Alignment.center,
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              Wrap(
                                                children: <Widget>[
                                                  Text(
                                                    snapshot.data[index]
                                                        .data['yazar isim'],
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Wrap(
                                                children: <Widget>[
                                                  Text(
                                                    snapshot.data[index]
                                                        .data['tarih'],
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          height: 65,
                                          width: 150,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only( bottom: 20),
                    alignment: Alignment.centerLeft,
                    child: Text("En Beğenilen Şiirler",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>TumSiirler()
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only( bottom: 20,right: 7),
                      alignment: Alignment.centerLeft,
                      child: Text("Tümünü Gör",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.pink.shade800),),
                    ),
                  ),
                ],
              ),
              Container(
                //şairlerin bulunduğu büyük container
                height: 380,
                color: Colors.white,
                margin: EdgeInsets.only(top:10),
                child:FutureBuilder(
                  future: getSiir(),
                  builder: (_, snapshot) {
                    if(snapshot.hasError){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(backgroundColor: Colors.orange,),);
                    }
                    else {
                      return ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder:(BuildContext context ,int index){
                            return   Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    navigateToSiirDetay(snapshot.data[index]);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(0.0, 2.0),
                                              blurRadius: 6.0)
                                        ]),
                                    height: 235,
                                    width: 165,
                                    margin: EdgeInsets.all(8),
                                    //color: Colors.white,
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          height: 145,
                                          width: 165,
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 98,
                                                    right: 75,
                                                    bottom: 20),
                                                height: 20,
                                                color: Colors.black12,
                                                alignment:
                                                Alignment.bottomCenter,
                                                child: Text(
                                                  snapshot.data[index]
                                                      .data['yazar'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 18),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Hero(
                                                tag: snapshot.data[index]
                                                    .data['resim'],
                                                child: Container(
                                                  child: Icon(
                                                    Icons.navigation,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                  alignment:
                                                  Alignment.bottomCenter,
                                                  margin: EdgeInsets.only(
                                                      top: 115, right: 115),
                                                ),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data[index]
                                                    .data['resim']),
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 145),
                                          alignment: Alignment.center,
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              Wrap(
                                                children: <Widget>[
                                                  Text(
                                                    snapshot.data[index]
                                                        .data['isim'],
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Wrap(
                                                children: <Widget>[
                                                  Text(
                                                    snapshot.data[index]
                                                        .data['yazar'],
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          height: 65,
                                          width: 150,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                      );
                    }
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
