import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/advert_services.dart';
import 'yazar_detay.dart';


class TumSairler extends StatefulWidget {

  @override
  _TumSairlerState createState() => _TumSairlerState();
}

class _TumSairlerState extends State<TumSairler> {
  @override
  void initState() {
    getSair();
    _advertService.showInters();
    _advertService.showBanner();
    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }

  final AdvertService _advertService = AdvertService();
  Future getSair() async{
    var firestore=Firestore.instance;
    QuerySnapshot qn= await firestore.collection("yazar_bilgi").getDocuments();
    return qn.documents;
  }
  navigateToDetail(DocumentSnapshot seyahat) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Details(
              seyahat: seyahat,
            )));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Şairler",style: TextStyle(fontFamily:'Caveat',fontSize: 30,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.pink.shade800,
        actions: <Widget>[
          /*Container(
           child: IconButton(
             icon: Icon(Icons.search,color: Colors.white,size: 25,),
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
              future: getSair(),
              builder: (_,snapshot){
                if(snapshot.hasError){
                  return Center(child: CircularProgressIndicator());
                }if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
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
                          navigateToDetail(snapshot.data[index]);
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

                                    height: 120,
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
                                        height: 60,
                                        color: Colors.white70,
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(height: 10,),
                                              Text(snapshot.data[index].data['yazar isim'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                              Text(snapshot.data[index].data['tarih'],style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),),
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
