import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passontroller = TextEditingController();
  final _addressController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          else
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  buildInputsForm(),
                  buildEnterButtom(context, model)
                ],
              ),
            );
        }));
  }

  Widget buildInputsForm() {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(hintText: 'Nome Completo'),
          validator: (text) => (text.isEmpty) ? 'Nome inválido' : null,
          controller: _nameController,
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
          controller: _emailController,
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'Senha'),
          obscureText: true,
          validator: (text) =>
              (text.isEmpty || text.length < 6) ? 'Senha inválida' : null,
          controller: _passontroller,
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'Endereço'),
          validator: (text) => (text.isEmpty) ? 'Endereço inválida' : null,
          controller: _addressController,
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget buildEnterButtom(BuildContext context, UserModel model) {
    return SizedBox(
        height: 44,
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              var userData = {
                'name': _nameController.text,
                'email': _emailController.text,
                'address': _addressController.text
              };

              model.signUp(
                  userData: userData,
                  pass: _passontroller.text,
                  onFail: _onFail,
                  onSuccess: _onSuccess);
            }
          },
          child: Text(
            'Criar Conta',
            style: TextStyle(fontSize: 18),
          ),
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
        ));
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Usuário criado com sucesso!'),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      )
    );

    Future.delayed(Duration(seconds: 2)).then(
      (_) => Navigator.of(context).pop()
    );
  }
  void _onFail() {
        _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Falha ao criar usuário!'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      )
    );
  }
}
