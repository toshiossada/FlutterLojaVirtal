import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            buildInputsForm(),
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
          decoration: InputDecoration(hintText: 'Nome Completo'),
          validator: (text) => (text.isEmpty) ? 'Nome inválido' : null,
        ),
        SizedBox(
          height: 16,
        ),
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
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'Endereço'),
          validator: (text) =>
              (text.isEmpty) ? 'Endereço inválida' : null,
        ),
        SizedBox(
          height: 16,
        ),
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
            'Criar Conta',
            style: TextStyle(fontSize: 18),
          ),
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
        ));
  }
}
