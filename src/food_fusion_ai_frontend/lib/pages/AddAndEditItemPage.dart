import 'package:flutter/material.dart';
class AddAndEditItemPage extends StatelessWidget{
  AddAndEditItemPage({
    super.key,
    required this.itemTitle, required this.itemDate, required this.itemAmount
  });

  final String itemTitle;
  final String itemDate;
  final String itemAmount;
  @override
  Widget build(BuildContext context){
    final itemTitleController = TextEditingController.fromValue(  TextEditingValue(text: itemTitle,));
    final itemDateController = TextEditingController.fromValue(  TextEditingValue(text: itemDate,));
    final itemAmountController = TextEditingController.fromValue(  TextEditingValue(text: itemAmount,));
    final is_new = ((itemTitle+itemDate+itemAmount) == "");
    return 
      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: FittedBox(
            fit: BoxFit.fitWidth, 
            child: Text(is_new ?'Add item' : 'Edit item')
          )
        ),
        body: Column(
          children: [
            TextField(
                  controller: itemTitleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Item name',
                    ),
                  ),
                
            SizedBox(height: 5,),
            TextField(
              controller: itemAmountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Amount in g',
              ),
            ),
            SizedBox(height: 5,),
            TextField(
              controller: itemDateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Expiration date in yyyy-mm-dd',
              )
            ),
            SizedBox(height: 5,),
            FloatingActionButton(onPressed: () {
            //when backend is implemented - add to list in backend
            //if(!is_new) delete old item
            Navigator.pop(context);
          },
            tooltip: is_new ?'Add item!' : 'Edit item!',
            child: is_new ? const Icon(Icons.add) : const Icon(Icons.edit), )
          ],
        ),
              
      );
  }
}