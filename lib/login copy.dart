import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  BuildContext _scaffoldContext;
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      Navigator.pushNamedAndRemoveUntil(
          _scaffoldContext, "/dashboard", (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Form(
      key: formKey,
      child: new ListView(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(top: 70.0),
            child: new Image.asset(
              'images/logo.png',
              height: 100.0,
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 40.0),
            child: new ListTile(
              leading: const Icon(Icons.mail),
              title: new TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                  hintText: "E-mail",
                ),
                validator: (String value) {
                  if (value.isEmpty) return 'E-mail Ã© obrigatÃ³rio';
                  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                      "\\@ [a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                      "(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";
                  RegExp regExp = new RegExp(p);
                  if (regExp.hasMatch(value)) {
                    return 'Email invalido';
                  }
                  return null;
                },
                onSaved: (val) => _email = val,
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.lock_outline),
            title: new TextFormField(
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                hintText: "Senha",
              ),
              validator: (val) => val.length < 6 ? 'senha curta' : null,
              onSaved: (val) => _password = val,
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 20.0),
            alignment: new Alignment(0.0, 0.0),
            child: new RaisedButton(
              child: new Text(
                "Entrar",
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.brown,
              onPressed: () {
                _submit();
              },
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 40.0),
            alignment: new Alignment(0.0, 0.0),
            child: new InkWell(
              child: new Text(
                'Esqueci minha senha',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.brown,
                ),
              ),
            ),
          ),
          new Container(
              margin: const EdgeInsets.only(top: 20.0),
              alignment: new Alignment(0.0, 0.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Text(
                    'Novo por aqui?',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  new InkWell(
                    child: new Text(
                      ' FaÃ§a seu cadastro!',
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ],
              )),
          new Builder(builder: (BuildContext context) {
            _scaffoldContext = context;
            return new Center();
          }),
        ],
      ),
    ));
  }
}
