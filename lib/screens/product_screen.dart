import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product.dart';

class ProductScreen extends StatefulWidget {
  final Product _product;

  ProductScreen(this._product);

  @override
  _ProductScreenState createState() => _ProductScreenState(_product);
}

class _ProductScreenState extends State<ProductScreen> {
  final Product _product;

  _ProductScreenState(this._product);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
