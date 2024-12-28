import 'package:flutter/material.dart';

class StartingPage extends StatelessWidget{
  final String username;
  StartingPage({required this.username});
  @override
  Widget build(BuildContext context){
    return Text("Das ist die Startseite von "+username);
  }
}