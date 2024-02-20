import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String model = 'camry';
  final String apiKey = 'YOUR_API_KEY';
  final String apiUrl = 'https://api.api-ninjas.com/v1/cars?model=';

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl$model'), headers: {
        'X-Api-Key': apiKey,
      });

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Car Data App'),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // Ma'lumotlarni ko'rsatish uchun UI kodlarini joylashtiring
              return Center(
                child: Text('API Response: ${snapshot.data}'),
              );
            }
          },
        ),
      ),
    );
  }
}
