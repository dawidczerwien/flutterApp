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
                context
                    .read<AuthenticationService>()
                    .signUp(
                      email: email.text.trim(),
                      password: passwd.text.trim(),
                    )
                    .then((value) =>
                        context.read<AuthenticationService>().signOut());
              },
              child: Text('Register')),
        ],
      ),
    );
  }
}
