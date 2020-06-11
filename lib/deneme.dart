import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DenemezApp extends StatefulWidget {
  @override
  _DenemezAppState createState() => _DenemezAppState();
}

class _DenemezAppState extends State<DenemezApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Demo"),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('yazar_bilgi').snapshots(),
        builder: (context,snapshot){
         if(!snapshot.hasData){
           return Center(
             child:CircularProgressIndicator(
               backgroundColor: Colors.deepPurple,
             ) ,
           );
         }else{
           return ListView.builder(
             itemCount: snapshot.data.documents.length,
             itemBuilder:(context,index){
               DocumentSnapshot myst=snapshot.data.documents[index];
               return Column(
                 children: <Widget>[
                   SizedBox(height: 25,),
                   FutureBuilder(
                     future: Firestore.instance.collection('yazar_bilgi/${myst['img']}/şiirler').getDocuments(),
                     builder: (BuildContext context,AsyncSnapshot snap){
                       if(snap.hasData){
                         if(snap.data!=null){
                           return CircleAvatar(
                             backgroundImage: NetworkImage(
                               '${snap.data.documents.toList()[0].data['img'].toString()}'
                             ),
                           );
                         }else{
                           return CircularProgressIndicator(
                             backgroundColor: Colors.black,
                           );
                         }
                       }return CircularProgressIndicator(
                         backgroundColor: Colors.yellow,
                       );
                     },
                   )
                 ],
               );
             },
           );
         }
        }

      ),
    );
  }
}
