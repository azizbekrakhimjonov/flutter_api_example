import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String logo = 'BMW';
  final String apiKey = 'PHuDznsl8Z/wjnpgwVRn9Q==xfiiy2NRdKRFj18j';
  final String apiUrl = 'https://api.api-ninjas.com/v1/logo?name=';

  Future<String?> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl$logo'), headers: {
        'X-Api-Key': apiKey,
      });

      if (response.statusCode == 200) {
        print(response.body);
        print(json.decode(response.body)[0]['image']);
        return json.decode(response.body)[0]['image'];
      } else {
        print('Error: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                fetchData();
              },
              child: Text('Fetch Data'),
            ),
            Text('$logo'.toUpperCase()),
            FutureBuilder<String?>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Image.network(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  );
                } else {
                  return Text('No Data');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
