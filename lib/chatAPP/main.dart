import 'package:flutter/material.dart';
import 'package:flutter_api_example/chatAPP/app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactListPage(),
    );
  }
}

class Contact {
  final String name;
  final String lastName;
  final int id;

  Contact({required this.name, required this.lastName, required this.id});
}

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<Contact> contacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(198, 141, 234, 1),
        title: Text('Messanger'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromRGBO(201, 146, 236, 1),
        child: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                'https://images.pexels.com/photos/17305999/pexels-photo-17305999.jpeg',
              )),
              title: Text(contacts[index].name),
              subtitle: Text(contacts[index].id.toString()),
              onTap: () {
                print(contacts);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MessageView(title: contacts[index].name),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _showAddContactDialog(context);
        },
        child: Icon(Icons.person_add),
      ),
    );
  }

  Future<void> _showAddContactDialog(BuildContext context) async {
    String name = '';
    String lastName = '';
    String id = '';

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Contact'),
          content: SafeArea(
            child: Container(
              height: 200,
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: InputDecoration(labelText: 'First Name'),
                  ),
                  TextField(
                    onChanged: (value) {
                      lastName = value;
                    },
                    decoration: InputDecoration(labelText: 'Last Name'),
                  ),
                  TextField(
                    onChanged: (value) {
                      id = value;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'ID'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (name.isNotEmpty && lastName.isNotEmpty && id.isNotEmpty) {
                  Contact contact = Contact(
                    name: name,
                    lastName: lastName,
                    id: int.parse(id),
                  );
                  setState(() {
                    contacts.add(contact);
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
