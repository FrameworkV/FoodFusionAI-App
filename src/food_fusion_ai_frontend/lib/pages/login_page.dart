import 'package:flutter/material.dart';
import '../app_structure.dart';
import 'forgot_password_page.dart';
import 'register_page.dart';
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
                checkpassword(userController.text,passwordController.text); 
                
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

  void checkpassword(String username, String password) {
    if(username=="hans"){

      if(password=="123"){
        userController.text= "eingeloggt";
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(username: username,)),
        );
      } else _login_failed(context);
    } else _login_failed(context);
  }

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
}