import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'BubleClass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class MessageView extends StatefulWidget {
  String title;
  MessageView({Key? key, required this.title}) : super(key: key);

  @override
  _MessageViewState createState() => _MessageViewState(title: title);
}

class _MessageViewState extends State<MessageView> {
  String title;
  _MessageViewState({Key? key, required this.title});
  List<String> messages = [];
  String _responseData = '';

  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _getData();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _postData(String txt) async {
    final String apiUrl =
        'https://65993ee1a20d3dc41cef70e7.mockapi.io/api/massage';
    final String postData = txt;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'data': postData},
      );

      if (response.statusCode == 201) {
        setState(() {
          _responseData =
              'Post muvaffaqiyatli bajarildi.\nResponse: ${response.body}';
        });
      } else {
        setState(() {
          _responseData = 'Xato yuz berdi.\nStatusCode: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _responseData = 'Xato yuz berdi.\nXatolik: $e';
      });
    }
  }

  Future<void> _getData() async {
    // final String apiUrl = 'https://65993ee1a20d3dc41cef70e7.mockapi.io/api/massage';
    final String apiUrl =
        'https://65993f04a20d3dc41cef712e.mockapi.io/api/chatapp';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          var list = json.decode(response.body) as List;
          print(list.last['data']);
          _responseData = list.last['data'];
          // if ("admin: $_responseData") {

          // }
          messages.add("admin: $_responseData");
        });
      } else {
        setState(() {
          _responseData = 'Xato yuz berdi.\nStatusCode: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _responseData = 'Xato yuz berdi.\nXatolik: $e';
      });
    }
  }

  void setMSG(txt) {
    setState(() {
      messages.add("You: $txt");
      _postData(txt);
      _getData();
    });
  }

  void rmMSG(msg) {
    setState(() {
      if (messages.isNotEmpty) {
        messages.remove(msg);
      }
      print(messages);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Stack(
        children: [
          Column(children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      rmMSG(messages[index]);
                    },
                    child: Bubble(
                      text: messages[index],
                    ),
                  );
                },
              ),
            ),
          ]),
          MessageBar(
            onSend: (txt) {
              setMSG(txt);
            },
            actions: [
              InkWell(
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 24,
                ),
                onTap: () {},
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: InkWell(
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.green,
                    size: 24,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
