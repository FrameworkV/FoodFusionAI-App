
import 'package:flutter/material.dart';

//other pages
import 'pages/home_page.dart';
import 'pages/chatbot_page.dart';
import 'pages/recipe_page.dart';
import 'pages/storage_page.dart';
import 'pages/test_api.dart';

class MyHomePage extends StatefulWidget {
  final String username;
  final String access_token;
  MyHomePage({required this.username, required this.access_token});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = StartingPage(username: widget.username, access_token:widget.access_token);
        break;
      case 1:
        page = RecipePage();
        break;
      case 2:
        page = StoragePage();
        break;
      case 3:
        page = ChatbotPage();
      case 4:
        page = TestAPI();       
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.local_restaurant),
                  label: Text('Recipes'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.kitchen),
                  label: Text('Storage'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.adb),
                  label: Text('Chatbot'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.terrain_sharp),
                  label: Text('TestAPI'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
                
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
        ],
      ),
    );
  }
}












