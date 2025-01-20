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
var chat_messages = [["hallo","request"], ["hallo zurück, das ist eine sehr lange nachricht llllllllllllllllllgfglfgfg gfgflgflgfglflgflfgfglflgl gflfglfglflgflgglfglg gflfglflgflglglfgl", "chatbot"]];
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
                ChatMessage(
                  message: message[0],
                  isSentByMe: (message[1]=="request"),
                )
                
                
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


//design

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  ChatMessage({required this.message, required this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment:
            isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSentByMe) ...[
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.blueAccent,
              child: Icon(
                Icons.adb,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
          ],
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.5, // Maximalbreite auf 70% der Bildschirmbreite setzen
            ),
            decoration: BoxDecoration(
              color: isSentByMe ? Colors.blueAccent : Colors.grey[300],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isSentByMe ? Colors.white : Colors.black,
              ),
              softWrap: true, // Zeilenumbruch aktivieren
              overflow: TextOverflow.visible, // Text wird umgebrochen, wenn nötig
            ),
          ),
          if (isSentByMe) ...[
            SizedBox(width: 10),
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.blueAccent,
              child: Text(
                'You',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}