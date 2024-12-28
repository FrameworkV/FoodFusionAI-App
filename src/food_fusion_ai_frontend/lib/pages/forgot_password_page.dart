import 'package:flutter/material.dart';
class ForgotPasswordPage extends StatelessWidget{
  final username;
  const ForgotPasswordPage({this.username});
  @override
  Widget build(BuildContext context){
    return Scaffold(body: Text("du hast dein Passwort vergessen"+username));
  }
}