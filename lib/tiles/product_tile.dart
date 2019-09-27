import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product.dart';
import 'package:loja_virtual/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final String _type;
  final Product _product;

  ProductTile(this._type, this._product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProductScreen(_product))),
      child: Card(
        child: (_type == 'grid') ? renderGridView(context) : renderListView(context),
      ),
    );
  }

  Widget renderGridView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 0.8,
          child: Image.network(
            _product.images[0],
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: renderInformationProduct(context, CrossAxisAlignment.center),
        )
      ],
    );
  }

  Widget renderListView(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Image.network(
            _product.images[0],
            fit: BoxFit.cover,
            height: 250,
          ),
        ),
        Flexible(
          flex: 1,
          child: renderInformationProduct(context, CrossAxisAlignment.start),
        )
      ],
    );
  }

  Widget renderInformationProduct(
      BuildContext context, CrossAxisAlignment cross) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: cross,
        children: <Widget>[
          Text(
            _product.title,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            "R\$ ${_product.price.toStringAsFixed(2)}",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 17.0,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
