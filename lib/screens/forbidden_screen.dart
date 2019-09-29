import 'package:flutter/material.dart';

import 'login_screen.dart';

class ForbiddenScreen extends StatelessWidget {
  final IconData icon;
  final String msg;

  ForbiddenScreen(this.msg, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 80,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            msg,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16,
          ),
          RaisedButton(
            child: Text(
              'Entrar',
              style: TextStyle(fontSize: 28),
            ),
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginScreen())),
          )
        ],
      ),
    );
  }
}
