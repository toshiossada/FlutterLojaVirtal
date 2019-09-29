import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String category;
  String id;
  String title;
  String description;
  double price = 0;
  List images;
  List sizes;

  Product.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data['title'];
    description = snapshot.data['description'];
    price = snapshot.data['price'];
    images = snapshot.data['images'];
    sizes = snapshot.data['sizes'];
  }

  Map<String, dynamic> toResumeMap(){
    return {
      'title': title,
      'price': price,
      'description': description
    };
  }
}
