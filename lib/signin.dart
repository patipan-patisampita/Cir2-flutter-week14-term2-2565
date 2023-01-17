import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isObscure = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    final url = Uri.parse("http://192.168.1.104/flutter-api/login.php");
    final response = await http.post(url, body: {
      "email": usernameController.text,
      "password": passwordController.text,
    });

    final datauser = jsonDecode(response.body);
    print(datauser);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(_isObscure);
    print(_login());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign In System"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/login.png'),
              height: 150,
              width: 200,
            ),
            Container(
              child: Text("SIGN IN SYSTEM"),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                        print(_isObscure);
                      });
                    },
                    icon: Icon(
                      _isObscure == false
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  _login();
                },
                child: Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
