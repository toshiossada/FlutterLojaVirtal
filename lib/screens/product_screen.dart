import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/cart_screen.dart';
import 'package:loja_virtual/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  final Product _product;

  ProductScreen(this._product);

  @override
  _ProductScreenState createState() => _ProductScreenState(_product);
}

class _ProductScreenState extends State<ProductScreen> {
  final Product product;
  String size;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) => NetworkImage(url)).toList(),
              dotSize: 4,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildTitles(primaryColor),
                buildPrices(primaryColor),
                buildSizes(primaryColor),
                buildBuyButtom(primaryColor),
                buildDescription(primaryColor)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildTitles(Color primaryColor) {
    return Text(
      product.title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      maxLines: 3,
    );
  }

  Widget buildPrices(Color primaryColor) {
    return Text(
      "R\$ ${product.price.toStringAsFixed(2)}",
      style: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
    );
  }

  Widget buildSizes(Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 16,
        ),
        Text(
          'Tamanho',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 34,
          child: GridView(
            padding: EdgeInsets.symmetric(vertical: 4),
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 8,
              childAspectRatio: 0.5,
            ),
            children: product.sizes
                .map((s) => GestureDetector(
                      onTap: () {
                        setState(() => size = s);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                                color: (s == size)
                                    ? primaryColor
                                    : Colors.grey[500],
                                width: 3.0)),
                        width: 50.0,
                        alignment: Alignment.center,
                        child: Text(s),
                      ),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }

  Widget buildBuyButtom(Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 44.0,
          child: RaisedButton(
            onPressed: size != null
                ? () {
                    if (UserModel.of(context).isLoggedIn()) {
                      var cProduct = CartProduct();
                      cProduct.size = size;
                      cProduct.quantity = 1;
                      cProduct.pid = product.id;
                      cProduct.category = product.category;
                      cProduct.product = product;

                      CartModel.of(context).addCartItem(cProduct);

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CartScreen()));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    }
                  }
                : null,
            child: Text(
              UserModel.of(context).isLoggedIn()
                  ? 'Adicionar ao Carrinho'
                  : 'Entre para comprar',
              style: TextStyle(fontSize: 18.0),
            ),
            color: primaryColor,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildDescription(Color primaryColor) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          Text(
            "Descrição",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          Text(
            product.description,
            style: TextStyle(fontSize: 16),
          )
        ]);
  }
}
