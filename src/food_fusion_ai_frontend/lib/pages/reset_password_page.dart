import 'package:flutter/material.dart';
import '../app_structure.dart';
import 'login_page.dart';
import 'register_page.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;




class ResetPasswordPage extends StatefulWidget{

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPage();
}

class _ResetPasswordPage extends State<ResetPasswordPage> {

  final emailController = TextEditingController();
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  bool _isObscure_password =true;
  bool _isObscure_repeat_password =true;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.fitWidth, 
          child: Text('Register!')
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(5)),
          TextField(
            controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'E-mail',
              ),
            ),
          Padding(padding: EdgeInsets.all(5),),
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
            obscureText: _isObscure_password,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              // this button is used to toggle the password visibility
              suffixIcon: IconButton(
                  icon: Icon(
                      _isObscure_password ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscure_password = !_isObscure_password;
                    });
                  })),
          ),
                    Padding(padding: EdgeInsets.all(5),),
          TextField(
            controller: repeatPasswordController,
            obscureText: _isObscure_repeat_password,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Repeat Password',
              // this button is used to toggle the password visibility
              suffixIcon: IconButton(
                  icon: Icon(
                      _isObscure_repeat_password ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscure_repeat_password = !_isObscure_repeat_password;
                    });
                  })),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text("Already registered?")
              ),
              FloatingActionButton(
                onPressed: () {
                newUser(emailController.text,userController.text,passwordController.text,repeatPasswordController.text); 
                
                },
                tooltip: 'Register',
                child: const Icon(Icons.login),
                
              ),
            ],
          ),
          
        ],
      )
    );
  }

  //utils

  void newUser(String email, String username, String password, String repeat_password) {
    if(password!=repeat_password){
      _register_failed(context, 0);
    } else{
      if(email=="" || username=="" ||password ==""){
        _register_failed(context, 3);
      }else{
        createUser(username, password, email);
      }

    }

  }

  Future<void> _register_failed(BuildContext context, int error_code) {
    String error_message = "";
    switch (error_code) {
      case 0:
        error_message = "Passwords are not equal";
        break;
      case 1:
        error_message = "User already exists";
        break;
      case 2:
        error_message = "Email has no @";  
      case 3:
        error_message = "Fill out every field";  
      default:
        error_message = "Some error occured while registering.";
    }
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Failed to Register'),
          content: Text(
            error_message,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Already registered?'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
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

  Future<void> _register_succeded(BuildContext context, String server_response) {

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Successfully registered!'),
          content: Text(
            server_response,
          ),
          actions: <Widget>[
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
  Future<void> createUser(String username, String password, String email) async {
    // Die URL der FastAPI-Anfrage
    var url = Uri.parse('http://localhost:8000/users/create_user');
    
    // Die Daten, die an die API gesendet werden
    var data = {
      'username': username,
      'password': password,
      'email': email,
    };

    // Führe die POST-Anfrage aus
    try {
      var response = await http.post(
        url,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data), // Die Daten werden als JSON gesendet
      );

      // Prüfen, ob die Anfrage erfolgreich war (Statuscode 200)
      if (response.statusCode == 200) {
        print('User erfolgreich erstellt!');
        Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
        );
        _register_succeded(context, response.body);
        // Hier kannst du die Antwort der API verarbeiten, wenn nötig
        print('Response Body: ${response.body}');
      } else {
        print('Fehler bei der Erstellung des Users: ${response.statusCode}');        
      _register_failed(context, 999);
      }
    } catch (e) {
      print('Fehler: $e');
      _register_failed(context, 999);
    }
  }
}