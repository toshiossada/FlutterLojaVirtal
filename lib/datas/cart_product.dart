import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/product.dart';

class CartProduct{
  String cid;
  String category;
  String pid;
  int quantity;
  String size;
  Product product;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot doc){
    cid = doc.documentID;
    category = doc.data['category'];
    pid = doc.data['pid'];
    quantity = doc.data['quantity'];
    size = doc.data['size'];
  }

  Map<String, dynamic> toMap(){
    return {
      'category' : category,
      'pid': pid,
      'quantity': quantity,
      'size': size,
      //'product': product.toResumeMap()
    };
  }
}