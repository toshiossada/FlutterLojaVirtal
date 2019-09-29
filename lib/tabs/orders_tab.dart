import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/forbidden_screen.dart';
import 'package:loja_virtual/tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      String uid = UserModel.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('users').document(uid).collection('orders').getDocuments(),
        builder: (context, snapshot){
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
          else{
            return ListView(
              children: snapshot
                .data
                .documents
                .map((doc)=> OrderTile(doc.documentID)).toList(),
            );
          }
        },
      );
    } else {
      return ForbiddenScreen('Faça o login para acompanhar', Icons.view_list);
    }
  }
}
