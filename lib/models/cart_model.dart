import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  CartModel(this.user) {
    if (user.isLoggedIn()) {
      _loadCartItens();
    }
  }

  var isLoading = false;
  UserModel user;
  List<CartProduct> products = [];
  String couponCode;
  int discountPercent = 0;

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void updatePrices() {
    notifyListeners();
  }

  void addCartItem(CartProduct product) {
    products.add(product);

    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .add(product.toMap())
        .then((doc) => product.cid = doc.documentID);

    notifyListeners();
  }

  void removeCartItem(CartProduct product) {
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(product.cid)
        .delete();

    products.remove(product);

    notifyListeners();
  }

  void decProduct(CartProduct product) {
    product.quantity--;
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(product.cid)
        .updateData(product.toMap());

    notifyListeners();
  }

  void incProduct(CartProduct product) {
    product.quantity++;
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(product.cid)
        .updateData(product.toMap());

    notifyListeners();
  }

  void _loadCartItens() async {
    var query = await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .getDocuments();

    products =
        query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }

  void setCoupom(String code, int percent) {
    this.discountPercent = percent;
    this.couponCode = code;
  }

  double getProductsPrice() {
    double price = 0.0;
    price = products
        .map<double>(
            (m) => (m.product != null) ? m.quantity * m.product.price : 0)
        .reduce((a, b) => a + b);

    return price;
  }

  double getDiscount() => getProductsPrice() * discountPercent / 100;

  double getShipPrice() => 9.99;

  double getTotalPrice() => getProductsPrice() + getShipPrice() - getDiscount();

  Future<String> finishOrder() async {
    if (products.length == 0) return null;

    isLoading = true;
    notifyListeners();

    var refOrder = await Firestore.instance.collection('orders').add({
      'clientId': user.firebaseUser.uid,
      'products': products.map((p) => p.toMap()).toList(),
      'shioPrice': getShipPrice(),
      'produtcsPrice': getProductsPrice(),
      'discount': getDiscount(),
      'totalPrice': getTotalPrice(),
      'status': 1
    });

    await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('orders')
        .document(refOrder.documentID)
        .setData({'orderId': refOrder.documentID});

    var query = await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart') 
        .getDocuments();

    for (var item in query.documents) {
      item.reference.delete();
    }
    
    products.clear();
    discountPercent = 0;
    couponCode = null;
    isLoading = false;

    notifyListeners();

    return refOrder.documentID;
  }
}
