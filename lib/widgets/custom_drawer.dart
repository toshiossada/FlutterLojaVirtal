import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController _pageController;

  CustomDrawer(this._pageController);

  Widget _drawerBack() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 203, 236, 241),
          Colors.white,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          _drawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 16),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8,
                      left: 0,
                      child: Text(
                        'Flutter\'s\nClothing',
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: buildHello(),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, 'Inicio', _pageController, 0),
              DrawerTile(Icons.list, 'Produtos', _pageController, 1),
              DrawerTile(Icons.location_on, 'Lojas', _pageController, 2),
              DrawerTile(
                  Icons.playlist_add_check, 'Meus Pedidos', _pageController, 3),
            ],
          )
        ],
      ),
    );
  }

  Widget buildHello() {
    return ScopedModelDescendant<UserModel>(
        builder: (context, child, model) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    if (model.isLoggedIn()) {
                      model.signOut();
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    }
                  },
                  child: Text(
                    model.isLoggedIn() ? 'Sair' : 'Entre ou cadastre-se >',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ));
  }
}
