import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson3/firebase_auth_services/firebase_auth.dart';
import 'package:lesson3/views/components/toast.dart';
import 'package:lesson3/views/login/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  late bool _isShowPassword;
  late bool _isShowConfirmPassword;
  bool _isSignup = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isShowPassword = false;
    _isShowConfirmPassword = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  void _handleRegister(context) async {
    setState(() {
      _isSignup = true;
    });
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    User? user = await _auth.signUpWithEmailAndPassword(context,email, password);
    setState(() {
      _isSignup = false;
    });
    if (user != null) {
      user.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Padding(
                padding: EdgeInsets.only( right: 8.0),
                child: Icon(Icons.check_circle_outline, color: Colors.green),
              ),
              Column(
                children: [
                  Text('Create a new account successfully'),
                  Text('Now verify form your email'),
                ],
              ),
            ],
          ),
          duration: Durations.extralong3,
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
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
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  hintText: ' Confirm password',
                  contentPadding: const EdgeInsets.all(15),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isShowConfirmPassword = !_isShowConfirmPassword;
                      });
                    },
                    icon: Icon(_isShowConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
                obscureText: !_isShowConfirmPassword,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => _handleRegister(context),
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: _isSignup
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Register',
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
              Navigator.pop(context);
            },
            child: const Text(
              'I have account?',
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
