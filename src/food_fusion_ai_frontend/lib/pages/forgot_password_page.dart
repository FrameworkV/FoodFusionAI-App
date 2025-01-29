import 'package:flutter/material.dart';
import 'login_page.dart';
import 'reset_password_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;




class ForgotPasswordPage extends StatefulWidget{

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {

  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.fitWidth, 
          child: Text('Reset your Password!')
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
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text("I know my password!")
              ),
              FloatingActionButton(
                onPressed: () {
                forgot_password(context, emailController.text);
                },
                tooltip: 'Send E-mail to reset password',
                child: const Icon(Icons.send),
                
              ),
            ],
          ),
          
        ],
      )
    );
  }

  //utils

  

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
        error_message = "Some error occured while sending E-mail.";
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
          title: Text('E-mail successfully sent!'),
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
  Future<void> forgot_password(BuildContext context, String email) async {
    // Die URL der FastAPI-Anfrage
    var url = Uri.parse('http://localhost:8000/users/forgot_password?email='+ email);
    
    // Die Daten, die an die API gesendet werden
    var data = {
      
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
        Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPasswordPage()),
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