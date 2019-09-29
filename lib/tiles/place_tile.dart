import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {

  final DocumentSnapshot doc;
  PlaceTile(this.doc);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 100,
            child: Image.network(
              doc.data['image'],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  doc.data['title'],
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Text(
                  doc.data['address'],
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('Ver no Mapa'),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
                onPressed: (){
                  launch('https://www.google.com/maps/search/?api=1&query=${doc.data['lat']},${doc.data['log']}');
                },
              ),
              FlatButton(
                child: Text('Ligar'),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
                onPressed: (){
                  launch('tel:${doc.data['phone']}');
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}