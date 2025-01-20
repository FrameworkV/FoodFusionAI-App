import 'package:flutter/material.dart';
import '../app_structure.dart';
import 'forgot_password_page.dart';
import 'register_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class LoginPage extends StatefulWidget{

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final userController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isObscure =true;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.fitWidth, 
          child: Text('Login Page')
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(5)),
          TextField(
            controller: userController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
              ),
            ),
          Padding(padding: EdgeInsets.all(5),),
          TextField(
            controller: passwordController,
            obscureText: _isObscure,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              // this button is used to toggle the password visibility
              suffixIcon: IconButton(
                  icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  })),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                );
              },
              child: Text("Forgot Password?")
              ),
              TextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text("Register")
              ),
              FloatingActionButton(
                onPressed: () {
                login(userController.text,passwordController.text); 
                
                },
                tooltip: 'Login',
                child: const Icon(Icons.login),
                
              ),
            ],
          ),
          
        ],
      )
    );
  }

  //utils

  Future<void> _login_failed(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Failed to login'),
          content: const Text(
            'Password or user name incorrect',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Forgot password?'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                );
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> login(String username, String password) async {
    // URL für den Login-Endpunkt
    var url = Uri.parse('http://localhost:8000/users/login');

    // Die Daten im x-www-form-urlencoded-Format
    var data = {
      'grant_type': 'password',
      'username': username,
      'password': password,
      'scope': '',
      'client_id': '',
      'client_secret': ''
    };

    try {
      // POST-Anfrage mit den Headern
      var response = await http.post(
        url,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: data,
      );

      // Überprüfen des Statuscodes
      if (response.statusCode == 200) {
        // Die JSON-Antwort dekodieren
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        // Den access_token extrahieren
        String accessToken = responseMap['access_token'];
        // Den access_token ausgeben
        print('Access Token: $accessToken');
        Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(username: username, access_token: '$accessToken')),
        );
      } else {
        // Fehler bei der Anfrage
        throw Exception('Fehler beim Login: ${response.statusCode}');
      }
    } catch (e) {
      // Fehlerbehandlung
      _login_failed(context);
      print('Fehler: $e');
    }
  }

}