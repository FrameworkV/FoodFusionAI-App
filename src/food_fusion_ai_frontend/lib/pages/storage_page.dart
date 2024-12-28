import 'package:flutter/material.dart';

class StoragePage extends StatelessWidget{
  var storage = ["Apple","Banana","peanuts","watermelon","Pasta"];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.fitWidth, 
          child: Text('Your storage')
      ),
      ),
    body:
FractionallySizedBox(
  widthFactor: 1,
  child: ListView(
          children: [         
            for(var item in storage)
            FractionallySizedBox(
              widthFactor: 1,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(item)),
            ),
          ],
        ),
      ),
    );
  }
}