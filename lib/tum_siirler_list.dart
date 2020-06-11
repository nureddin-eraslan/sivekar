import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share/share.dart';
import 'package:sivekar/siir_details.dart';

import 'services/advert_services.dart';


class TumSiirler extends StatefulWidget {

  @override
  _TumSiirlerState createState() => _TumSiirlerState();
}

class _TumSiirlerState extends State<TumSiirler> {

  final AdvertService _advertService=AdvertService();
  Future getSiir() async{
    var firestore=Firestore.instance;
    QuerySnapshot qn= await firestore.collection("popüler şiirler").getDocuments();
    return qn.documents;
  }

  navigateToSiirDetay(DocumentSnapshot siir) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SiirDetay(
              siir: siir,
            )));
  }
  @override
  void initState() {
    getSiir();
    _advertService.showInters();
    _advertService.showBanner();
    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Şiirler",style: TextStyle(fontFamily:'Caveat',fontSize: 30,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.orange.shade800,
        actions: <Widget>[
          /* Container(
           child: IconButton(
             icon: Icon(Icons.youtube_searched_for,color: Colors.white,),
             onPressed: (){

             },
           ),
         )*/
        ],
        centerTitle: true,
      ),
      body: Container(

        margin: EdgeInsets.all(10),
        child:Container(

          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:  Container(
            child: FutureBuilder(
              future: getSiir(),
              builder: (_,snapshot){
                if(snapshot.hasError){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else{
                  return GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 30,
                    ),
                    itemBuilder: (BuildContext context,int index){
                      return GestureDetector(
                        onTap: (){
                          navigateToSiirDetay(snapshot.data[index]);
                        },
                        child: Container(
                          //bu her bir elemanın olduğu container

                          height: 150,
                          width: 100,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 6.0)
                            ],
                            //color: Colors.pink,
                            borderRadius: BorderRadius.circular(10),
                            //image: DecorationImage()
                          ),
                          child: Wrap(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(

                                    height: 110,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        color: Colors.black26,
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot.data[index].data['resim']),
                                            fit: BoxFit.cover
                                        ),
                                        borderRadius: BorderRadius.circular(10)
                                    ),

                                  ),

                                  Wrap(
                                    children: <Widget>[
                                      Container(
                                        height: 80,
                                        color: Colors.white70,
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(height: 5,),
                                              Text(snapshot.data[index].data['isim'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                              SizedBox(height: 8,),
                                              Text(snapshot.data[index].data['yazar'],style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
