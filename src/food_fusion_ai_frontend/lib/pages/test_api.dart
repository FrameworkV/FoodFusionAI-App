import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class TestAPI extends StatefulWidget{
  @override
  State<TestAPI> createState() => _TestAPIState();
}

class _TestAPIState extends State<TestAPI> {

  final url ="https://jsonplaceholder.typicode.com/posts";

var _postsJson = [];
  void FetchPosts() async {
    try{ 
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;

      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {}
  }

  
  @override
  void initState() {
    super.initState();
    FetchPosts();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView.builder(
        itemCount: _postsJson.length,
        itemBuilder: (context, indexmindex) {
          final post = _postsJson[indexmindex];
          return Text("Title: ${post["title"]}\n Body: ${post["body"]}\n\n");
        }
      )
    );
  }
}