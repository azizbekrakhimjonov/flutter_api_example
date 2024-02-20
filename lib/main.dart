import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String model = 'camry';
  final String apiKey = 'PHuDznsl8Z/wjnpgwVRn9Q==xfiiy2NRdKRFj18j';
  final String apiUrl = 'https://api.api-ninjas.com/v1/cars?model=';

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl$model'), headers: {
        'X-Api-Key': apiKey,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body[0]);
        print(data);
        return json.decode(response.body);
      } else {
        print('Errtelor: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchData();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Car Data App'),
        ),
        body: Center(
          child: Text('${fetchData()}'),
        ),
      ),
    );
  }
}
