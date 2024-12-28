import 'package:flutter/material.dart';
import '../app_structure.dart';
class LoginPage extends StatefulWidget{

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();

  final passwordController = TextEditingController();

  bool _isObscure =true;

  void checkpassword(String username, String password) {
    if(username=="hans"){

      if(password=="123"){
        userController.text= "eingeloggt";
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
    }
    //print(username.compareTo(password));
    //print("button pressed");
    //print(username+ "\n" +password);
  }

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
          
          FloatingActionButton(
            onPressed: () {
            checkpassword(userController.text,passwordController.text); 
            
            },
            tooltip: 'Login',
            child: const Icon(Icons.login),
          ),
        ],
      )
    );
  }
}