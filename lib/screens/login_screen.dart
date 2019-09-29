import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/singup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  final _emailController = TextEditingController();
  final _passontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
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
                    buildForgetPassButtom(),
                    buildEnterButtom(context, model)
                  ],
                ),
              );
          },
        ));
  }

  Widget buildInputsForm() {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _emailController,
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
          controller: _passontroller,
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

  Widget buildEnterButtom(BuildContext context, UserModel model) {
    return SizedBox(
        height: 44,
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {}
            model.signIn(
                email: _emailController.text,
                pass: _passontroller.text,
                onFail: _onFail,
                onSuccess: _onSuccess);
          },
          child: Text(
            'Entrar',
            style: TextStyle(fontSize: 18),
          ),
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
        ));
  }

  void _onSuccess() => Navigator.of(context).pop();


  void _onFail() {
        _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Falha ao entrar!'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      )
    );
  }
}
