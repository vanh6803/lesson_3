import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson3/views/login/login.dart';

class Home extends StatelessWidget {
  Home({super.key});

  User? user = FirebaseAuth.instance.currentUser;

  void _handleLogout(context) async {
    await FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.check_circle_rounded, color: Colors.green),
            ),
            Text('Logout successfully'),
          ],
        ),
      ),
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Welcome ${user?.email}'),
            ),
            ElevatedButton(
              onPressed: () => _handleLogout(context),
              child: const Text('Log out'),
            )
          ],
        ),
      ),
    );
  }
}
