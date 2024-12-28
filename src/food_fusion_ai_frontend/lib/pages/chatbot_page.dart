import 'package:flutter/material.dart';

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Chat Messages
            Expanded(
              child: ListView(
                      children: [
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
                      ]
              ),
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
                myController.clear();
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