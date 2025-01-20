import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'AddAndEditItemPage.dart';
class StoragePage extends StatelessWidget{
  var storage = [["Apple","2024-02-04","99"],["Banana","2025-01-24","234"],["peanuts","2025-02-24","100"],["watermelon","2025-02-09","455"],["Pasta","2030-02-04","1000"]];
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
      Column(
        children:[ 
          Expanded(
          child: ListView(
                  children: [         
                    for(var item in storage)
                    Padding(
                      padding: const EdgeInsets.all(1.5),
                      child: StorageListItem(item_name: item[0], expiration_date: item[1],amount: item[2],),
                    ),
                  ],
                ),
          ),
          FloatingActionButton(onPressed: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddAndEditItemPage(itemTitle: "", itemAmount: "",itemDate: "",)),
                );
          },
            tooltip: 'Add items!',
            child: const Icon(Icons.add), )
        ]
      ),
    );
  }
}

class StorageListItem extends StatelessWidget {
  const StorageListItem({
    super.key,
    required this.item_name, required this.expiration_date, required this.amount
  });

  final String item_name;
  final String expiration_date;
  final String amount;
  @override
  Widget build(BuildContext context) {
    DateTime expiration_date_as_DateTime = DateTime.parse(expiration_date);
    bool expires_in_less_than_a_week = DateTime.now().isAfter(expiration_date_as_DateTime.subtract(Duration(days:7)));
    bool is_expired = DateTime.now().isAfter(expiration_date_as_DateTime);

    return Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.5, // Maximalbreite auf 70% der Bildschirmbreite setzen
            ),
            decoration: BoxDecoration(
              color: is_expired ? const Color.fromARGB(255, 235, 69, 13): expires_in_less_than_a_week ? const Color.fromARGB(255, 239, 199, 186) : const Color.fromARGB(255, 234, 244, 229),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        item_name,
                        style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold
                        ),
                        softWrap: true, // Zeilenumbruch aktivieren
                        overflow: TextOverflow.visible, // Text wird umgebrochen, wenn nötig
                      ),
                      Text(amount + "g"),
                      Text(
                        expiration_date,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        softWrap: true, // Zeilenumbruch aktivieren
                        overflow: TextOverflow.visible, // Text wird umgebrochen, wenn nötig
                      ),
                      
                      Text(is_expired ? "Is expired!" : expires_in_less_than_a_week ? "Expires soon!" : ""),
                                 
                    ],
                  ),
                ),
                IconButton(onPressed: () {
                  //when backend delete funktion is implemented
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddAndEditItemPage(itemTitle: item_name, itemAmount: amount,itemDate: expiration_date,)),
                );
                },
                  tooltip: 'Edit item',
                  icon: const Icon(Icons.edit), 
                ),
                IconButton(onPressed: () {
                  //when backend delete funktion is implemented
                },
                  tooltip: 'Delete item',
                  icon: const Icon(Icons.delete), 
                )
              ],
            ),
            
          ) ;
  }
}