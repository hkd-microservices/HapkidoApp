import 'package:flutter/material.dart';
import 'package:hkd_app/authpage.dart';
import 'package:hkd_app/login.dart';
import 'package:hkd_app/register.dart';

import 'dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new Login(),
        '/register': (BuildContext context) => new Register(),
        '/authpage': (BuildContext context) => new Authpage(),
        //'/login_screen_3': (BuildContext context) => new LoginScreen3(),
        '/dashboard': (BuildContext context) => new Dashboard(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Authpage(),
    );
  }
}
