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
      ),
      body: Column(
        children: [
          TextField(
            controller: email,
            decoration: InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: passwd,
            decoration: InputDecoration(labelText: "Hasło"),
          ),
          ElevatedButton(
              onPressed: () {
                context.read<AuthenticationService>().signIn(
                      email: email.text.trim(),
                      password: passwd.text.trim(),
                    );
              },
              child: Text('Login')),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text('Register')),
        ],
      ),
    );
  }
}
