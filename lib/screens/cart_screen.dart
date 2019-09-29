import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/forbidden_screen.dart';
import 'package:loja_virtual/screens/orders_screen.dart';
import 'package:loja_virtual/tiles/cart_tile.dart';
import 'package:loja_virtual/widgets/cart_price.dart';
import 'package:loja_virtual/widgets/dicount_card.dart';
import 'package:loja_virtual/widgets/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Carrinho'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                var p = model.products.length;

                return Text(
                  '${p ?? 0} ${p <= 1 ? 'Item' : 'Itens'}',
                  style: TextStyle(fontSize: 17),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoggedIn()) {
            return Center(child: CircularProgressIndicator());
          } else if (!UserModel.of(context).isLoggedIn()) {
            return ForbiddenScreen('Faça o login para adicionar produtos!', Icons.remove_shopping_cart);
          } else if (model.products == null || model.products.length == 0) {
            return Center(
              child: Text(
                'Nenhum produto no carrinho',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.products
                      .map((product) => CartTile(product))
                      .toList(),
                ),
                DiscountCard(),
                ShipCard(),
                CartPrice(() async {
                  var orderId = await model.finishOrder();
                  if(orderId != null){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => OrderScreen(orderId))
                    );
                  }
                })
              ],
            );
          }
        },
      ),
    );
  }
}
