import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Authentication.dart';

class RegisterPage extends StatelessWidget {
  final email = TextEditingController();
  final passwd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Rejestracja'), backgroundColor: Color(0xFF243B55)),
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
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<AuthenticationService>()
                        .signUp(
                          email: email.text.trim(),
                          password: passwd.text.trim(),
                        )
                        .then((value) => Navigator.pop(context));
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
