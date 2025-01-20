import 'package:flutter/material.dart';

class StartingPage extends StatelessWidget{
  final String username;
  final String access_token;
  StartingPage({required this.username, required this.access_token});
  @override
  Widget build(BuildContext context){
    return Text("Das ist die Startseite von "+username+ "\n"+access_token);
  }
}