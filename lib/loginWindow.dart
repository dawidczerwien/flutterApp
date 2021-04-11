import 'package:flutter/material.dart';
import 'package:flutter_app1/registerWindow.dart';
import 'package:provider/provider.dart';
import 'Authentication.dart';

class LoginPage extends StatelessWidget {
  final email = TextEditingController();
  final passwd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Logowanie'),
          backgroundColor: Color(0xFF243B55),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.2,
              0.8,
            ],
            colors: [
              Color(0xFF141E30),
              Color(0xFF243B55),
            ],
          )),
          child: Column(
            children: [
              TextField(
                controller: email,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 16, color: Colors.white)),
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              TextField(
                obscureText: true,
                controller: passwd,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: "Hasło",
                    labelStyle: TextStyle(fontSize: 16, color: Colors.white)),
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              SizedBox(
                  width: 105,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthenticationService>().signIn(
                            email: email.text.trim(),
                            password: passwd.text.trim(),
                          );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterPage()));
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ));
  }
}
