import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson3/firebase_auth_services/firebase_auth.dart';
import 'package:lesson3/views/home/home.dart';
import 'package:lesson3/views/register/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late bool _isShowPassword;
  bool _isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isShowPassword = false;
  }

  void _handleLogin(context) async {
    setState(() {
      _isLogin = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user =
        await _auth.signInWithEmailAndPassword(context, email, password);

    setState(() {
      _isLogin = false;
    });

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.check_circle_rounded, color: Colors.green),
              ),
              Text('Login successfully'),
            ],
          ),
        ),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'email',
                  contentPadding: EdgeInsets.all(15),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: const EdgeInsets.all(15),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isShowPassword = !_isShowPassword;
                      });
                    },
                    icon: Icon(_isShowPassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
                obscureText: !_isShowPassword,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => _handleLogin(context),
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'login',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Register()));
            },
            child: const Text(
              'Create new account?',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
