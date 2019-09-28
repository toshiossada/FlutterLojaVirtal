import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/singup_screen.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Criar Conta",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignUpScreen())),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            buildInputsForm(),
            buildForgetPassButtom(),
            buildEnterButtom(context)
          ],
        ),
      ),
    );
  }

  Widget buildInputsForm() {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(hintText: 'E-mail'),
          keyboardType: TextInputType.emailAddress,
          validator: (text) =>
              (text.isEmpty || !text.contains('@') || !text.contains('.'))
                  ? 'E-mail inválido'
                  : null,
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'Senha'),
          obscureText: true,
          validator: (text) =>
              (text.isEmpty || text.length < 6) ? 'Senha inválida' : null,
        )
      ],
    );
  }

  Widget buildForgetPassButtom() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: FlatButton(
            onPressed: () {},
            child: Text(
              'Esqueci minha senha',
              textAlign: TextAlign.right,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }

  Widget buildEnterButtom(BuildContext context) {
    return SizedBox(
        height: 44,
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {}
          },
          child: Text(
            'Entrar',
            style: TextStyle(fontSize: 18),
          ),
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
        ));
  }
}
