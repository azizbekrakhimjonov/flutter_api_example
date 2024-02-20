import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Connection',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textFieldController = TextEditingController();
  String _responseData = '';

  Future<void> _postData() async {
    final String apiUrl =
        'Your_api_urls';
    final String postData = _textFieldController.text;

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
    final String apiUrl =
        'https://658ecc672871a9866e79d42c.mockapi.io/api/contacts';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          _responseData =
              'Get muvaffaqiyatli bajarildi.\nResponse: ${response.body}';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter API Connection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textFieldController,
              decoration: InputDecoration(labelText: 'Ma\'lumotni kiriting'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _postData,
                  child: Text('Post'),
                ),
                ElevatedButton(
                  onPressed: _getData,
                  child: Text('Get'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(_responseData),
          ],
        ),
      ),
    );
  }
}
