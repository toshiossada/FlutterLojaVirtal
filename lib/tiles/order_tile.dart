import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final String orderId;

  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('orders')
              .document(orderId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              var status = snapshot.data['status'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Codigo do pedido: ${snapshot.data.documentID}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    _buildProductsText(snapshot.data),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    'Status do Pedido:',
                    style: TextStyle(fontWeight: FontWeight.bold), 
                  ),
                  SizedBox(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCircle('1', 'Preparação', status, 1),
                      Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey[500],
                      ),
                      _buildCircle('2', 'Transporte', status, 2),
                      Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey[500],
                      ),
                      _buildCircle('3', 'Entrega', status, 3),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot) {
    var items = snapshot.data['products']
        .map<String>((item) {
          return '${item['quantity']} x ${item['product']['title']} (R\$ ${item['product']['price'].toStringAsFixed(2)})';
        })
        .toList()
        .join('\n');

    return 'Descrição:\n${items}\nTotal R\$ ${snapshot.data['totalPrice'].toStringAsFixed(2)}';
  }

  Widget _buildCircle(
      String title, String subTitle, int status, int thisStatus) {
    Color backColor;
    Widget child;

    if (status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(
        title,
        style: TextStyle(color: Colors.white),
      );
    } else if (status == thisStatus) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white,);
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subTitle),
      ],
    );
  }
}
