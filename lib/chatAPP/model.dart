import 'package:flutter/material.dart';

class PrefixContact extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String id;

  PrefixContact(
      {super.key,
      required this.firstname,
      required this.lastname,
      required this.id});

  @override
  State<PrefixContact> createState() => _PrefixContact();
}

class _PrefixContact extends State<PrefixContact> {
  final List<String> myData = <String>[];

  var count = 0;

  void _addListTile() {
    setState(() {
      myData.add("fs");
      print(myData);
    });
  }

  void _remuveItem(int index) {
    setState(() {
      myData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView'),
      ),
      body: Container(
        color: Color(0xffa5a5a5),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: myData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                          backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/17305999/pexels-photo-17305999.jpeg',
                      )),
                      onLongPress: () {
                        _remuveItem(index);
                        print(myData);
                      },
                      title: Center(child: Text(myData[index])),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addListTile,
        child: Icon(Icons.add),
      ),
    );
  }
}
