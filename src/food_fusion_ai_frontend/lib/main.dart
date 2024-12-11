import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 0, 0)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }


}

class MyHomePage extends StatefulWidget {
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
        page = StartingPage();
        break;
      case 1:
        page = RecipePage();
        break;
      case 2:
        page = StoragePage();
        break;
      case 3:
        page = ChatbotPage();
        break;        
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




class StartingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Text("Das ist die Startseite");
  }
}

class RecipePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Text("Hier werden Rezepte vorgeschlagen");
  }
}

class StoragePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Text("Hier kann man sein Lager ansehen");
  }
}

class ChatbotPage extends StatefulWidget{
  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
var chat_messages = [["hallo","request"], ["hallo zurück", "chatbot"]];
 @override
  Widget build(BuildContext context){
    
    return Scaffold(
      body: 
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Chat Messages
            for(var message in chat_messages)
              Builder(
                builder: (context) {
                  if (message[1] == "request") //
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(message[0]),
                      ],
                    );

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(message[0]),
                    ],
                  );
                },
              ),            
              
            TextField(
              controller: myController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ask our bot something',
              ),
            ),
            
            FloatingActionButton(
              // When the user presses the button, show an alert dialog containing
              // the text that the user has entered into the text field.
              onPressed: () {
                chat_messages.add([myController.text,"request"]);
                chat_messages.add([getAnswer(myController.text), "chatbot"]);
                setState(() {});
              },
              tooltip: 'Send the message!',
              child: const Icon(Icons.send_rounded),
            ),
          ],
        ),
        
    );
  }
}

//funktions
getAnswer(String request) {
  return "here will be the answer to the message, created by the AI";
}
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(pair.asLowerCase, 
        style: style,
        semanticsLabel: pair.asPascalCase,
        ),
      ),
    );
  }
}
